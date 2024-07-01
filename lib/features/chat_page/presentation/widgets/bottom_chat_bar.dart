import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class BottomChatBar extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController;
  String receiverId, senderId;
  BottomChatBar({
    super.key,
    required this.messageController,
    required this.receiverId,
    required this.senderId,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          GestureDetector(
            child: Image(
              image: Assets.images.mountainView.provider(),
              height: 50,
              width: 50,
            ),
            onTap: () {},
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            child: Image(
              image: Assets.images.paperPlane.provider(),
              height: 50,
              width: 50,
            ),
            onTap: () {
              String? content = _messageController.text;
              _messageController.text = '';
              final newMessage = Message(
                time: DateTime.now(),
                content: content ?? 'No message',
                seen: true,
                myMessage: true,
                receiverId: receiverId,
                senderId: senderId,
              ).toMap();
              firestore
                  .collection('users')
                  .doc(senderId)
                  .collection('conversation')
                  .doc(receiverId)
                  .collection('messages')
                  .add(newMessage);
              firestore
                  .collection('users')
                  .doc(receiverId)
                  .collection('conversation')
                  .doc(senderId)
                  .collection('messages')
                  .add(newMessage);
            },
          )
        ],
      ),
    );
  }
}
