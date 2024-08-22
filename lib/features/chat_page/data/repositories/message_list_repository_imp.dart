import 'package:chat_app/features/chat_page/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/chat_page/data/models/message_list_model.dart';
import 'package:chat_app/features/chat_page/domain/repositories/message_list_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MessageListRepositoryImp implements MessageListRepository {
  MessageListRemoteDataSource messageListRemoteDataSource;

  MessageListRepositoryImp(this.messageListRemoteDataSource);

  @override
  FutureOr<(MessageListModel?, String?)> getMessageList({
    required senderId,
    required receiverId,
  }) async {
    return await messageListRemoteDataSource.getMessageList(
      senderId: senderId,
      receiverId: receiverId,
    );
  }
}
