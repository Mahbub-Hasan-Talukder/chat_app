import 'package:chat_app/features/my_drawer/data/models/my_drawer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
MyDrawerRemoteDataSource myDrawerRemoteDataSource(Ref ref) {
  return MyDrawerRemoteDataSource();
}

class MyDrawerRemoteDataSource {
  String photoLink =
      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';
  FutureOr<(MyDrawerModel?, String?)> myDrawer() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final data = await getUserData((auth.currentUser?.uid)!);
    if (data != null) {
      return (
        MyDrawerModel(photoLink: data['photoUrl'], isActive: data['isActive']),
        null
      );
    }
    return (null, 'no data found');
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('users').doc(uid);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      return snapshot.data();
    } else {
      print('No user data found for ID: $uid');
      return null;
    }
  }
}
