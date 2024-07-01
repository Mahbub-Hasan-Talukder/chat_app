import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        .orderBy('time', descending: true)
        .snapshots();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
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
            ),
          ),
        ],
      ),
    );
  }
}
