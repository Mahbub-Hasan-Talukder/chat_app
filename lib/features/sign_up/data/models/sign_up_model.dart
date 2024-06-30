import 'package:chat_app/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({required super.user});

  static Map<String, dynamic> toMap({required User user}) {
    return {
      'name': user.displayName,
      'email': user.email,
      'isActive': true,
      'photoUrl':
          'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
    };
  }
}
