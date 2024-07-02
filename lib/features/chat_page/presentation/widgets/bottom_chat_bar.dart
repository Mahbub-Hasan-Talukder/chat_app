import 'dart:io';

import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class BottomChatBar extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController;
  String receiverId, senderId;
  String receiverName, senderName;
  BottomChatBar({
    super.key,
    required this.messageController,
    required this.receiverName,
    required this.receiverId,
    required this.senderName,
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
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                File imageFile = File(pickedFile.path);
                try {
                  String fileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child('chat_images')
                      .child(senderId)
                      .child(fileName);
                  final uploadTask = storageRef.putFile(imageFile);
                  uploadTask.snapshotEvents.listen((event) {
                    final progress = event.bytesTransferred / event.totalBytes;
                    print('Upload progress: ${progress * 100}%');
                    LinearProgressIndicator(
                      value: progress,
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  });
                  final taskSnapshot = await uploadTask.catchError((error) {
                    print('Upload error: $error');
                    throw Exception('Failed to upload image');
                  });
                  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

                  if (downloadUrl.isNotEmpty) {
                    _saveMessageToFirestore(
                      content: null,
                      downloadUrl: downloadUrl,
                      senderName: senderName,
                      receiverName: receiverName,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to send image: $e')),
                  );
                }
              }
            },
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
              if (content.isNotEmpty) {
                _saveMessageToFirestore(
                  content: content,
                  downloadUrl: null,
                  senderName: senderName,
                  receiverName: receiverName,
                );
              }
            },
          )
        ],
      ),
    );
  }

  void _saveMessageToFirestore({
    required String? downloadUrl,
    required String? content,
    required String senderName,
    required String receiverName,
  }) {
    final newMessage = Message(
      time: DateTime.now(),
      photoUrl: downloadUrl,
      content: content,
      seen: true,
      myMessage: true,
      receiverName: receiverName,
      receiverId: receiverId,
      senderName: senderName,
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
        .doc(senderId)
        .collection('conversation')
        .doc(receiverId)
        .set(newMessage);

    firestore
        .collection('users')
        .doc(receiverId)
        .collection('conversation')
        .doc(senderId)
        .collection('messages')
        .add(newMessage);
    firestore
        .collection('users')
        .doc(receiverId)
        .collection('conversation')
        .doc(senderId)
        .set(newMessage);
  }
}
