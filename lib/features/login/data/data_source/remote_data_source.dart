import 'package:chat_app/features/login/data/models/login_model.dart';
import 'package:chat_app/features/login/presentation/widgets/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'remote_data_source.g.dart';

@riverpod
LoginRemoteDataSource loginRemoteDataSource(Ref ref) {
  return LoginRemoteDataSource();
}

class LoginRemoteDataSource {
  FutureOr<(LoginModel?, String?)> login({required UserData userData}) async {
    final email = userData.email;
    final pass = userData.pass;
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = credential.user;
      if (user != null) {
        return (LoginModel(user: user), null);
      }
    } on FirebaseAuthException catch (e) {
      return (null, e.code);
    } catch (e) {
      return (null, e.toString());
    }
    return (null, null);
  }
}
