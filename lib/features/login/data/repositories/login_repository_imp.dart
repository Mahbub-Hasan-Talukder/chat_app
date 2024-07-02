import 'package:chat_app/features/login/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/login/data/models/login_model.dart';
import 'package:chat_app/features/login/domain/repositories/login_repository.dart';
import 'package:chat_app/features/login/presentation/widgets/user_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp(this.loginRemoteDataSource);

  @override
  FutureOr<(LoginModel?, String?)> login({
    required UserData userData,
  }) async {
    final res = await loginRemoteDataSource.login(userData: userData);
    if (res.$1?.user != null) print(res.$1!.user.uid);
    return res;
  }
}
