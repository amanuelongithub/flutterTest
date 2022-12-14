import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/post.dart';
import 'storage_methods.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String name,
    String quantity,
    String description,
    Uint8List file,
    String username,
    String uid,
  ) async {
    String res = "Something error occured";

    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        name: name,
        quantity: quantity,
        description: description,
        postId: postId,
        postUrl: postUrl,
        datePublished: DateTime.now(),
        username: username,
        uid: uid,
      );

      _firebaseFirestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
