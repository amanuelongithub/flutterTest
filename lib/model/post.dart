
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String description;
  final String quantity;
  final String uid;
  final String postId;
  final datePublished;
  final String postUrl;
  const Post({
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.username,
    required this.quantity,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "uid": uid,
        "username": username,
        "quantity": quantity,
      };
}
