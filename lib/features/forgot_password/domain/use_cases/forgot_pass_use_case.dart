import 'package:chat_app/features/forgot_password/domain/entities/forgot_pass_entity.dart';
import 'package:chat_app/features/forgot_password/domain/repositories/forgot_pass_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_pass_use_case.g.dart';

@riverpod
ForgotPassUseCase forgotPassUseCase(ForgotPassUseCaseRef ref) {
  final forgotPassRepository = ref.read(forgotPassRepositoryProvider);
  return ForgotPassUseCase(forgotPassRepository: forgotPassRepository);
}

class ForgotPassUseCase {
  final ForgotPassRepository forgotPassRepository;

  ForgotPassUseCase({required this.forgotPassRepository});

  FutureOr<(ForgotPassEntity?, String?)> forgotPass({
    required String email,
  }) async {
    return await forgotPassRepository.forgotPass(
      email: email,
    );
  }
}
