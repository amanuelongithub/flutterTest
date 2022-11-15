import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String uid;


  const User({
    required this.username,
    required this.email,
    required this.uid,

  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }
}
