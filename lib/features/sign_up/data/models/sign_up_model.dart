import 'package:chat_app/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({required super.user});

  static Map<String, dynamic> toMap({required User user}) {
    return {
      'name': user.displayName,
      'email': user.email,
      'isActive': true,
    };
  }
}
