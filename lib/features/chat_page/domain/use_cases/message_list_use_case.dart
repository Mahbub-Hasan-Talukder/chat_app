import 'package:chat_app/features/chat_page/domain/entities/message_list_entity.dart';
import 'package:chat_app/features/chat_page/domain/repositories/message_list_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_use_case.g.dart';

@riverpod
MessageListUseCase messageListUseCase(MessageListUseCaseRef ref) {
  final messageListRepository = ref.read(messageListRepositoryProvider);
  return MessageListUseCase(messageListRepository: messageListRepository);
}

class MessageListUseCase {
  final MessageListRepository messageListRepository;

  MessageListUseCase({required this.messageListRepository});

  FutureOr<(MessageListEntity?, String?)> getMessageList({
    required senderId,
    required receiverId,
  }) async {
    return await messageListRepository.getMessageList(
      senderId: senderId,
      receiverId: receiverId,
    );
  }
}
