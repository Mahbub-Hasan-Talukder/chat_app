import 'package:chat_app/features/forgot_password/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/forgot_password/data/models/forgot_pass_model.dart';
import 'package:chat_app/features/forgot_password/domain/repositories/forgot_pass_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ForgotPassRepositoryImp implements ForgotPassRepository {
  ForgotPassRemoteDataSource forgotPassRemoteDataSource;

  ForgotPassRepositoryImp(this.forgotPassRemoteDataSource);

  @override
  FutureOr<(ForgotPassModel?, String?)> forgotPass({
    required String email,
  }) async {
    return await forgotPassRemoteDataSource.forgotPass(email: email);
  }
}
