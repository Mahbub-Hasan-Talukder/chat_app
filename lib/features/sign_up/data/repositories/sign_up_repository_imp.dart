import 'package:chat_app/features/sign_up/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/sign_up/data/models/sign_up_model.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class SignUpRepositoryImp implements SignUpRepository {
  SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepositoryImp(this.signUpRemoteDataSource);

  @override
  FutureOr<(SignUpModel?, String?)> signUp({
    required UserData userData,
  }) async {
    (SignUpModel?, String?) createdUser =
        await signUpRemoteDataSource.signUp(userData: userData);

    if (createdUser.$1 != null) {
      User user = createdUser.$1!.user;
      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        await user.updateProfile(displayName: userData.name);
        await user.reload();
        user = auth.currentUser!;

        signUpRemoteDataSource.saveUserInfo(
          userMappedData: SignUpModel.toMap(user: user),
          collection: 'users',
          uid: user.uid,
        );
      } catch (e) {
        return (null, e.toString());
      }
    }
    return createdUser;
  }
}
