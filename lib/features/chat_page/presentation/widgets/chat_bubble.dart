import 'package:chat_app/features/chat_page/utils/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: EdgeInsets.all(10.0),
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
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: message.content,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                )
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatTimestamp(message.time),
                style: TextStyle(color: Colors.white70, fontSize: 12.0),
              ),
              SizedBox(width: 5.0),
              Icon(
                message.seen ? Icons.done_all : Icons.done,
                color: message.seen ? Colors.blue : Colors.white70,
                size: 16.0,
              ),
            ],
          ),
        ],
      ),
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
}
