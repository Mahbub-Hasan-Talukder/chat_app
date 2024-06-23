import 'package:chat_app/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final signUpRepository = ref.read(signUpRepositoryProvider);
  return SignUpUseCase(signUpRepository: signUpRepository);
}

class SignUpUseCase {
  final SignUpRepository signUpRepository;
  SignUpUseCase({required this.signUpRepository});

  FutureOr<(SignUpEntity?, String?)> signUp({
    required UserData userData,
  }) async {
    return await signUpRepository.signUp(
      userData: userData,
    );
  }
}
