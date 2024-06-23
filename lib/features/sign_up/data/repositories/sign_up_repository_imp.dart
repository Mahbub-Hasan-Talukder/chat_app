import 'package:chat_app/features/sign_up/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/sign_up/data/models/sign_up_model.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class SignUpRepositoryImp implements SignUpRepository {
  SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepositoryImp(this.signUpRemoteDataSource);

  @override
  FutureOr<(SignUpModel?, String?)> signUp({
    required UserData userData,
  }) async {
    (SignUpModel?, String?) nmodel =
        await signUpRemoteDataSource.signUp(userData: userData);
    if (nmodel.$1 != null) {
      User user = nmodel.$1!.user;
      // print('disp name: ${user.displayName} \n email: ${user.email} \n uid: ${user.uid}');
      try {
        final db = FirebaseFirestore.instance;
        final saveUserInfo = <String, String>{
          'name': user.displayName ??
              'No Name', // Provide a default value or handle the null case
          'email': user.email ??
              'No Email', // Provide a default value or handle the null case
        };
        await db.collection('users').doc(user.uid).set(saveUserInfo);
      } catch (e) {
        print(e.toString());
        return (null, e.toString());
      }
    }
    return nmodel;
  }
}
