import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/widgets/profile_picture_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ConnectedUserList extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String currentUserId = auth.currentUser!.uid;

    final chatsStream = firestore
        .collection('users')
        .doc(currentUserId)
        .collection('conversation')
        .orderBy('time', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder<QuerySnapshot>(
        stream: chatsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No chats found.'));
          }

          final chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              var chatData = chatDocs[index].data() as Map<String, dynamic>;
              var receiverId = chatData['receiverId'] ?? '';
              var senderId = chatData['senderId'] ?? '';
              var senderName = chatData['senderName'] ?? '';
              var receiverName = chatData['receiverName'] ?? '';
              var lastMessageContent = chatData['content'] ?? '';
              var lastMessageSeen = chatData['seen'];
              var unseenMsgCounter = chatData['unseenMsgCounter'];
              var lastMessageIsMine =
                  (auth.currentUser?.uid == chatData['senderId']);
              var time = chatData['time'] != null
                  ? (chatData['time'] as Timestamp).toDate()
                  : DateTime.now();

              return FutureBuilder<DocumentSnapshot>(
                future: (senderId == currentUserId)
                    ? firestore.collection('users').doc(receiverId).get()
                    : firestore.collection('users').doc(senderId).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                      subtitle: Text('Loading...'),
                    );
                  }

                  if (userSnapshot.hasError) {
                    return ListTile(
                      title: Text('Error: ${userSnapshot.error}'),
                      subtitle: Text('Error: ${userSnapshot.error}'),
                    );
                  }

                  if (!userSnapshot.hasData) {
                    return ListTile(
                      title: Text('User not found'),
                      subtitle: Text('User not found'),
                    );
                  }

                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: ProfilePictureHolder(
                        userData: userData,
                        rad: 50,
                      ),
                      title: (currentUserId == senderId)
                          ? Text('@ $receiverName')
                          : Text('@ $senderName'),
                      subtitle: (lastMessageContent.isEmpty)
                          ? const Text('Sent image')
                          : Text(
                              lastMessageContent,
                              maxLines: 1,
                            ),
                      trailing: Column(
                        children: [
                          Text(
                            DateFormat('hh:mm a').format(time),
                          ),
                          (lastMessageIsMine)
                              ? (lastMessageSeen)
                                  ? Icon(
                                      Icons.done_all,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                              : Text(''),
                        ],
                      ),
                      onTap: () {
                        firestore
                            .collection('users')
                            .doc(senderId)
                            .collection('conversation')
                            .doc(receiverId)
                            .update({'unseenMsgCounter': 0});

                        context.push(MyRoutes.chatPage, extra: {
                          'receiverUid': userData['uid'] ?? 'User',
                          'receiverName': userData['name'] ?? 'uid',
                          'receiverIsActive': userData['isActive'] ?? false,
                          'receiverPhotoUrl': userData['photoUrl'],
                        });
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
