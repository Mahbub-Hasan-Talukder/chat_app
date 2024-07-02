import 'package:chat_app/features/forgot_password/domain/entities/forgot_pass_entity.dart';
import 'package:chat_app/features/forgot_password/domain/use_cases/forgot_pass_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_pass_controller.g.dart';

@riverpod
class ForgotPassController extends _$ForgotPassController {
  @override
  FutureOr<(ForgotPassEntity?, String?)> build() {
    return (null, null);
  }

  void forgotPass({required String email}) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(forgotPassUseCaseProvider).forgotPass(email: email);
    });
  }
}
