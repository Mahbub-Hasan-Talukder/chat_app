import 'package:chat_app/features/chat_page/domain/entities/message_list_entity.dart';
import 'package:chat_app/features/chat_page/domain/use_cases/message_list_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_controller.g.dart';

@riverpod
class MessageListController extends _$MessageListController {
  @override
  FutureOr<(MessageListEntity?, String?)> build() {
    return (null, null);
  }

  void getMessageList({required senderId, required receiverId}) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(messageListUseCaseProvider).getMessageList(
            senderId: senderId,
            receiverId: receiverId,
          );
    });
  }
}
