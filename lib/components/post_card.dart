import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/utils/fade_animation.dart';
import 'package:get/get.dart';

import '../utils/colors..dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Container(
        width: double.maxFinite,
        height: 393,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 161, 161, 161).withOpacity(0.4),
                offset: const Offset(10, 10),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 46,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 239, 239),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              // widget.snap['username'],
              widget.snap['name'],
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              //  Get.to(() => DetailPage(
              //       title: widget.snap['title'],
              //       content: widget.snap['content'],
              //       description: widget.snap['description'],
              //       price: widget.snap['price'],
              //       postId: widget.snap['postId'],
              //       photoUrl: widget.snap['postUrl'],
              //     )),
              child: Hero(
                tag: widget.snap['postId'],
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.snap['postUrl'],
                      fit: BoxFit.contain,
                      width: double.maxFinite,
                      height: 230,
                      errorWidget: (context, url, error) => SizedBox(
                        height: double.infinity,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: '!',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red)),
                                TextSpan(
                                    text: 'Unable to load image',
                                    style: TextStyle(
                                      color: Color.fromARGB(221, 49, 49, 49),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              )),
          Expanded(
            child: Container(
              // alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              decoration: BoxDecoration(
                // color: Colors.yellow,
                // borderRadius: BorderRadius.only(
                //   topRight: Radius.circular(10),
                //   bottomRight: Radius.circular(10),
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Quantity :",
                            style: TextStyle(
                                color: Color.fromARGB(172, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.snap['quantity'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ]),
                    Spacer(),
                    Text(
                      widget.snap['description'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(120, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 7,
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
