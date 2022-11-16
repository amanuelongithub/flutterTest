import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertest/components/default_button.dart';
import 'package:fluttertest/components/header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertest/components/tabButton.dart';
import 'package:fluttertest/screen/addpost.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/post_card.dart';
import '../utils/colors..dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  late PageController _pageController;
  final user = FirebaseAuth.instance.currentUser!;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      _selectedPage = page;
                    });
                  },
                  controller: _pageController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.maincolor,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots(), //get all data and streambuilder used as as real time
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: Text(
                                        "...",
                                        style: TextStyle(
                                            color: AppColors.maincolor),
                                      ));
                                    }
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: Text(
                                        "...",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                184, 138, 138, 138)),
                                      ));
                                    }
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                        "...",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                184, 138, 138, 138)),
                                      ));
                                    } else if (snapshot.hasData) {
                                      return Header(
                                        snap: snapshot.data,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      /* Text(
                            "Find the best \nShoes for you",
                            style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(170, 0, 0, 0)),
                          ),
                         */
                                      Expanded(
                                        child: SizedBox(
                                            height: 48,
                                            child: TextField(
                                              // controller: searchtextcontroller,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                      Icons.search,
                                                      color: Colors.grey),
                                                  hintText: 'Search',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  )),
                                              keyboardType: TextInputType.text,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      9), // <-- Radius
                                            ),
                                            onPrimary: Colors.black26,
                                            primary: AppColors.seccolor,
                                            shadowColor: Colors.transparent,
                                            minimumSize: Size(80, 40)),
                                        onPressed: () {
                                          Get.to(() => AddPost());
                                        },
                                        child: Text(
                                          "Post to",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .snapshots(), //get all data and streambuilder used as as real time
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.maincolor,
                                  ),
                                );
                              }
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text(
                                "No Content, Please post an item. Thankyou",
                                style: TextStyle(
                                    color: Color.fromARGB(184, 138, 138, 138)),
                              ));
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                "Unabel to get the data",
                                style: TextStyle(
                                    color: Color.fromARGB(184, 138, 138, 138)),
                              ));
                            }

                            return ListView.builder(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                padding: EdgeInsets.only(bottom: 10, top: 20),
                                itemBuilder: (context, index) {
                                  if (snapshot.hasData) {
                                    return PostCard(
                                      snap: snapshot.data!.docs[index].data(),
                                    );
                                  } else if (!snapshot.hasData) {
                                    return const Center(
                                        child: Text(
                                      "There is No Post",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              246, 152, 152, 152)),
                                    ));
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text("Some Error occured",
                                          style: TextStyle(fontSize: 20)),
                                    );
                                  } else
                                    return Container();
                                });
                          },
                        )),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Signed in as",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            user.email!,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(9), // <-- Radius
                                ),
                                onPrimary: Colors.black38,
                                primary: AppColors.maincolor,
                                shadowColor: Colors.transparent,
                                minimumSize: Size(360, 50)),
                            onPressed: () => FirebaseAuth.instance.signOut(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "SignOut",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.maincolor,
              ),
              width: double.infinity,
              height: 70,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabButton(
                        text: "Home",
                        selectedPage: 0,
                        pageNumber: _selectedPage,
                        onPressed: () {
                          _changePage(0);
                        }),
                    TabButton(
                        text: "Setting",
                        selectedPage: 1,
                        pageNumber: _selectedPage,
                        onPressed: () {
                          _changePage(1);
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
