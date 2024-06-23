import 'package:chat_app/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:chat_app/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<(SignUpEntity?, String?)> build() {
    return (null, null);
  }

  void signUp(UserData userData) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(signUpUseCaseProvider).signUp(userData: userData);
    });
  }
}
