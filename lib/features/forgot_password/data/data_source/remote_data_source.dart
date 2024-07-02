import 'package:chat_app/features/forgot_password/data/models/forgot_pass_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
ForgotPassRemoteDataSource forgotPassRemoteDataSource(Ref ref) {
  return ForgotPassRemoteDataSource();
}

class ForgotPassRemoteDataSource {
  static final auth = FirebaseAuth.instance;
  FutureOr<(ForgotPassModel?, String?)> forgotPass(
      {required String email}) async {
    String? status, errorStatus;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = 'Reset password email sent')
        .catchError(
          (e) => errorStatus = e.toString(),
        );
    return (ForgotPassModel(status: status), errorStatus);
  }
}
