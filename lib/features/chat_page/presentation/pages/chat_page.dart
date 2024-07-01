import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:chat_app/features/chat_page/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/chat_page/presentation/riverpod/message_list_controller.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/bottom_chat_bar.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/user_messages.dart';
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

class ChatPage extends ConsumerStatefulWidget {
  final String uid;
  final String name;
  final bool isActive;
  final String photoUrl;

  ChatPage({
    Key? key,
    required this.uid,
    required this.name,
    required this.isActive,
    required this.photoUrl,
  }) : super(key: key);
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
          title: widget.name,
          content: (widget.isActive) ? 'Online' : 'Offline',
          photoUrl: widget.photoUrl,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: UserMessages(uid: widget.uid),
            ),
            BottomChatBar(
              messageController: _messageController,
              senderId: (auth.currentUser?.uid)!,
              receiverId: widget.uid,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
