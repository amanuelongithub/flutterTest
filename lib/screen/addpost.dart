import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/components/default_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../service/firestore_methods.dart';
import '../utils/colors..dart';
import '../utils/utils.dart';
import 'home_screen.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String username = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _quantitycontroller = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  void getEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  void postImage(
    String uid,
    String username,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
        _nameController.text,
        _quantitycontroller.text,
        _descriptionController.text,
        _file!,
        username,
        uid,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        Get.snackbar("Posted seccessfully!", "");
        clearImage();
        Get.off(() => HomePage());
      } else {
        setState(() {
          _isLoading = false;
        });

        Get.snackbar(res, "");
      }
    } catch (e) {
      // Utils.showSnackBar(e.toString());
    }
  }

  _selectImag(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text('Create Post '),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantitycontroller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post to",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        elevation: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9), // <-- Radius
                    ),
                    backgroundColor: Colors.white),
                onPressed: () {
                  _selectImag(context);
                },
                child: Text(
                  "Add Image",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              children: [
                _isLoading
                    ? LinearProgressIndicator(
                        color: AppColors.maincolor,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                      ),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  children: [
                    const Divider(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.maincolor,
                            radius: 25,
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: AppColors.seccolor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _nameController,
                                  showCursor: true,
                                  cursorColor: Theme.of(context).primaryColor,
                                  enableInteractiveSelection: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 126, 126, 126),
                                        fontWeight: FontWeight.bold),
                                    border: inputBorder,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 126, 126, 126),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _quantitycontroller,
                                  showCursor: true,
                                  cursorColor: Theme.of(context).primaryColor,
                                  enableInteractiveSelection: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: "Quantity",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 126, 126, 126),
                                        fontWeight: FontWeight.bold),
                                    border: inputBorder,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 126, 126, 126),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: _descriptionController,
                                  showCursor: true,
                                  cursorColor: Theme.of(context).primaryColor,
                                  enableInteractiveSelection: true,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    hintText: 'Write a caption...',
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 126, 126, 126),
                                        fontWeight: FontWeight.bold),
                                    border: inputBorder,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 126, 126, 126),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 126, 126, 126))),
                                  child: _file == null
                                      ? const Center(
                                          child: Icon(
                                          Icons.image,
                                          color: Color.fromARGB(
                                              255, 126, 126, 126),
                                          size: 80,
                                        ))
                                      : Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(_file!),
                                                  fit: BoxFit.contain)),
                                        )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: _file != null,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9), // <-- Radius
                                              ),
                                              backgroundColor: Colors.black),
                                          onPressed: clearImage,
                                          child: Text(
                                            "Clear Image",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                      replacement: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                    SizedBox(
                      height: 60,
                    ),
                    DefaultButton(
                        text: "Post",
                        press: () {
                          postImage(_auth.currentUser!.uid, username);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
