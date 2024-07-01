class Message {
  DateTime time;
  String content;
  String receiverId;
  String senderId;
  bool seen;
  bool myMessage;

  Message({
    required this.time,
    required this.content,
    required this.seen,
    required this.myMessage,
    required this.receiverId,
    required this.senderId,
  });
  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'content': content,
      'seen': seen,
      'myMessage': myMessage,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }
}
