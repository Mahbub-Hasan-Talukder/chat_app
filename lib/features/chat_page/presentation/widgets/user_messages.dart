import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:chat_app/features/chat_page/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/chat_page/presentation/riverpod/message_list_controller.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/bottom_chat_bar.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class UserMessages extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid;
  UserMessages({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    String senderId = auth.currentUser!.uid;
    String receiverId = uid;
    final data = firestore
        .collection("users")
        .doc(senderId)
        .collection("conversation")
        .doc(receiverId)
        .collection("messages")
        .orderBy('time', descending: false)
        .snapshots();
    return StreamBuilder(
      stream: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No messages found.'));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index].data();
            var text = data['content'] ?? 'No message';
            var newSenderId = data['senderId'] ?? 'No message';
            var newReceiverId = data['receiverId'] ?? 'No message';
            var seen = data['seen'] ?? false;
            var timestamp = data['time'] != null
                ? (data['time'] as Timestamp).toDate()
                : DateTime.now();

            return ChatBubble(
              message: Message(
                time: timestamp,
                content: text,
                seen: seen,
                myMessage: senderId == newSenderId,
                receiverId: newReceiverId,
                senderId: newSenderId,
              ),
            );
          },
        );
      },
    );
  }
}
