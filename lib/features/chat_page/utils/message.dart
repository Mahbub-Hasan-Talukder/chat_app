import 'package:flutter/material.dart';

class Message {
  DateTime time;
  String? content;
  String receiverId;
  String senderId;
  bool seen;
  bool myMessage;
  String? photoUrl;

  Message({
    required this.time,
    required this.content,
    required this.seen,
    required this.myMessage,
    required this.receiverId,
    required this.senderId,
    required this.photoUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'content': content,
      'seen': seen,
      'myMessage': myMessage,
      'receiverId': receiverId,
      'senderId': senderId,
      'photoUrl': photoUrl,
    };
  }
}
