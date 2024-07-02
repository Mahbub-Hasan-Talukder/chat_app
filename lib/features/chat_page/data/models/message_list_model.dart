import 'package:chat_app/features/chat_page/domain/entities/message_list_entity.dart';

class MessageListModel extends MessageListEntity {
  MessageListModel({
    required super.messages,
  });

  // static MessageListModel fromJson(Map<String, dynamic> json) {
  //   final String _ = json['_'];

  //   return MessageListModel(
  //     _: _,
  //   );
  // }
}
