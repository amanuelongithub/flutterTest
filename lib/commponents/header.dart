import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../utils/colors..dart';

class Header extends StatefulWidget {
  final snap;
  const Header({Key? key, this.snap}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "👋 Hello:",
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.maincolor,
                    fontFamily: "HandoSoft",
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: ' ${widget.snap['username']}',
                style: TextStyle(
                    fontSize: 27,
                    color: AppColors.maincolor,
                    fontFamily: "HandoSoft",
                    fontWeight: FontWeight.bold)),
          ]),
        ),
        Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              user.email!,
              style: const TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 188, 188, 188)),
            ))
      ],
    );
  }
}
