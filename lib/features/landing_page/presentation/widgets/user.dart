import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String id;
  final String name;
  final String email;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory MyUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return MyUser(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
