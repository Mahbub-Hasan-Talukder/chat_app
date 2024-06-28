import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommonFirebaseStorageRepository {
  Future<String> storeFileToFireBase(String ref, File file) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
