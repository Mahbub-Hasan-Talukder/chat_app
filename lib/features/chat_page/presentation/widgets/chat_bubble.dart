import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBubble extends ConsumerWidget {
  final Message message;
  final FirebaseAuth auth = FirebaseAuth.instance;

  ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('photUrl:  ${message.content}');
    return GestureDetector(
      onLongPress: () async {
        await _editMessage(context, ref);
      },
      child: Row(
        mainAxisAlignment: (message.myMessage)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          (!message.myMessage && message.photoUrl != null)
              ? CircleAvatar(
                  child: Image(
                    image: NetworkImage(message.photoUrl!),
                  ),
                  radius: 30,
                )
              : const SizedBox(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: message.myMessage
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.shadow,
              borderRadius: message.myMessage
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            child: Column(
              crossAxisAlignment: (message.myMessage)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                (message.photoUrl == null)
                    ? RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: message.content,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Image(
                        image: NetworkImage(
                          message.photoUrl!,
                        ),
                      ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                title: Column(
                                  children: [
                                    AbsorbPointer(
                                      absorbing:
                                          (message.myMessage) ? false : true,
                                      child: TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await _editMessage(context, ref);
                                        },
                                        child: const Text('Edit'),
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await _deleteMessage();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20,
                        )),
                    Text(
                      _formatTimestamp(message.time),
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12.0),
                    ),
                    const SizedBox(width: 5.0),
                    (message.myMessage)
                        ? Icon(
                            message.seen ? Icons.done_all : Icons.done,
                            color: message.seen ? Colors.blue : Colors.white70,
                            size: 16.0,
                          )
                        : const Text(''),
                  ],
                ),
              ],
            ),
          ),
          (message.myMessage && message.photoUrl != null)
              ? CircleAvatar(
                  child: Image(
                    image: NetworkImage(message.photoUrl!),
                  ),
                  radius: 30,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Future<void> _editMessage(BuildContext context, WidgetRef ref) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final myDocRef = await db
        .collection('users')
        .doc(message.senderId)
        .collection('conversation')
        .doc(message.receiverId)
        .collection('messages')
        .doc(message.messageId);
    final otherDocRef = await db
        .collection('users')
        .doc(message.receiverId)
        .collection('conversation')
        .doc(message.senderId)
        .collection('messages')
        .doc(message.messageId);

    final data = await myDocRef.get();
    final content = data['content'];
    showDialog(
        context: context,
        builder: (_) {
          TextEditingController edit = TextEditingController(text: content);
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.shadow,
                  ),
                  controller: edit,
                ),
              ],
            ),
            //  content: const Text('Dialog Content'),
            actions: [
              TextButton(
                onPressed: () async {
                  await myDocRef.update({'content': edit.text});
                  await otherDocRef.update({'content': edit.text});
                  _updateLastMessage(
                    senderId: message.senderId,
                    receiverId: message.receiverId,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Edit'),
              ),
            ],
          );
        });
  }

  Future<void> _deleteMessage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .doc(message.senderId)
        .collection('conversation')
        .doc(message.receiverId)
        .collection('messages')
        .doc(message.messageId)
        .delete();
    await db
        .collection('users')
        .doc(message.receiverId)
        .collection('conversation')
        .doc(message.senderId)
        .collection('messages')
        .doc(message.messageId)
        .delete();
    _updateLastMessage(
      senderId: message.senderId,
      receiverId: message.receiverId,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return "${timestamp.day}/${timestamp.month}/${timestamp.year}";
    } else {
      return "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
    }
  }

  void _updateLastMessage({
    required senderId,
    required receiverId,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final myDocRef = await firestore
        .collection('users')
        .doc(senderId)
        .collection('conversation')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time')
        .get();
    if (myDocRef.docs.isEmpty) {
      await firestore
          .collection('users')
          .doc(senderId)
          .collection('conversation')
          .doc(receiverId)
          .delete();
      await firestore
          .collection('users')
          .doc(receiverId)
          .collection('conversation')
          .doc(senderId)
          .delete();
    } else {
      final recentMsg = myDocRef.docs.first.data();
      await firestore
          .collection('users')
          .doc(senderId)
          .collection('conversation')
          .doc(receiverId)
          .set(recentMsg);
      await firestore
          .collection('users')
          .doc(receiverId)
          .collection('conversation')
          .doc(senderId)
          .set(recentMsg);
    }
  }
}
