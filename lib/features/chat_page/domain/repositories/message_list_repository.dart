import 'package:chat_app/features/chat_page/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/chat_page/data/repositories/message_list_repository_imp.dart';
import 'package:chat_app/features/chat_page/domain/entities/message_list_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_repository.g.dart';

@riverpod
MessageListRepository messageListRepository(Ref ref) {
  final messageListRemoteDataSource =
      ref.read(messageListRemoteDataSourceProvider);
  return MessageListRepositoryImp(messageListRemoteDataSource);
}

abstract class MessageListRepository {
  FutureOr<(MessageListEntity?, String?)> getMessageList({
    required senderId,
    required receiverId,
  });
}
