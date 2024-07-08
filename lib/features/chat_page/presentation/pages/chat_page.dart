import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/bottom_chat_bar.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/user_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String receiverUid;
  final String? receiverName;
  final bool receiverIsActive;
  final String receiverPhotoUrl;

  const ChatPage({
    super.key,
    required this.receiverUid,
    required this.receiverName,
    required this.receiverIsActive,
    required this.receiverPhotoUrl,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: MyListTile(
          title: widget.receiverName ?? 'no reciever name in chate page',
          content: (widget.receiverIsActive) ? 'Online' : 'Offline',
          photoUrl: widget.receiverPhotoUrl,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: UserMessages(uid: widget.receiverUid),
            ),
            BottomChatBar(
              messageController: _messageController,
              senderName: (auth.currentUser?.displayName) ??
                  'no auth name in chat page',
              senderId: (auth.currentUser?.uid)!,
              receiverName:
                  widget.receiverName ?? 'no reciever name in chat page',
              receiverId: widget.receiverUid,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
