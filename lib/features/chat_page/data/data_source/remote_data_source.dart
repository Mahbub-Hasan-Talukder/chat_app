import 'dart:async';
import 'package:chat_app/features/chat_page/data/models/message_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
MessageListRemoteDataSource messageListRemoteDataSource(Ref ref) {
  return MessageListRemoteDataSource();
}

class MessageListRemoteDataSource {
  FutureOr<(MessageListModel?, String?)> getMessageList({
    required senderId,
    required receiverId,
  }) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore
          .collection("users")
          .doc(senderId)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots();
      return (null, null);
    } catch (e) {
      return (null, e.toString());
    }
  }
}
// class MessageListRemoteDataSource {
//   Stream<QuerySnapshot<Map<String, dynamic>>>? getMessageList({
//     required senderId,
//     required receiverId,
//   }) {
//     try {
//       FirebaseFirestore _firestore = FirebaseFirestore.instance;
//       Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore
//         .collection("users")
//         .doc(senderId)
//         .collection("messages").orderBy("timestamp", descending: false).snapshots();
//       return data;
//     } catch (e) {
//       // return (null, e.toString());
//     }
//     return null;
//   }
// }
