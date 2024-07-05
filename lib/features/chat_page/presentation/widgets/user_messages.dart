import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages found.'));
                }

                final docs = snapshot.data!.docs;

                makeMessagesAsSeen(
                  senderId: senderId,
                  receiverId: receiverId,
                );

                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var messageId = docs[index].id;
                    var data = docs[index].data() as Map<String, dynamic>;
                    var text = data['content'];
                    var photoUrl = data['photoUrl'];
                    var newSenderId = data['senderId'];
                    var newReceiverId = data['receiverId'];
                    var seen = data['seen'] ?? false;
                    var timestamp = data['time'] != null
                        ? (data['time'] as Timestamp).toDate()
                        : DateTime.now();
                    var senderName = data['senderName'];
                    var receiverName = data['receiverName'];
                    return ChatBubble(
                      message: Message(
                        time: timestamp,
                        content: text,
                        seen: seen,
                        myMessage: senderId == newSenderId,
                        receiverName: receiverName!,
                        receiverId: newReceiverId!,
                        senderId: newSenderId,
                        senderName: senderName!,
                        photoUrl: photoUrl,
                        unseenMsgCounter: null,
                        messageId: messageId,
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

  void makeMessagesAsSeen({senderId, receiverId}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var messagesCollection = db
        .collection('users')
        .doc(receiverId)
        .collection('conversation')
        .doc(senderId)
        .collection('messages');
    var lastMessage = db
        .collection('users')
        .doc(receiverId)
        .collection('conversation')
        .doc(senderId);

    QuerySnapshot querySnapshot = await messagesCollection.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await messagesCollection.doc(doc.id).update({'seen': true});
    }

    lastMessage.update({'seen': true});
  }
}
