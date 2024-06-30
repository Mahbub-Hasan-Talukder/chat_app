import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title, content;
  const MyListTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: CircleAvatar(
        backgroundImage: Assets.images.user.provider(),
        radius: 20,
      ),
      title: Text(title),
      subtitle: Text(
        content,
        maxLines: 1,
      ),
    );
  }
}
