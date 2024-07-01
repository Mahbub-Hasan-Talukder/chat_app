import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

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
      body: Column(
        children: [
          // Expanded(child: _buildChatList(context)), // Display chat messages
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 700),
                BottomChatBar(messageController: _messageController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomChatBar extends StatelessWidget {
  const BottomChatBar({
    super.key,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () {},
        )
      ],
    );
  }
}
