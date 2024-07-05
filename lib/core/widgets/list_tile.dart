import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title, content;
  final String? photoUrl;
  const MyListTile({
    super.key,
    required this.title,
    required this.content,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: CircleAvatar(
          backgroundImage: (photoUrl != null) ? NetworkImage(photoUrl!) : null,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
      subtitle: Text(
        content,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
