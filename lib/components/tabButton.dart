import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final VoidCallback onPressed;

  const TabButton(
      {Key? key,
      required this.text,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? Color.fromARGB(205, 255, 255, 255)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        width: MediaQuery.of(context).size.width / 2.6,
        padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0),
        margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 12.0,
            horizontal: selectedPage == pageNumber ? 0 : 2.0),
        duration: Duration(milliseconds: 900),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontWeight: selectedPage == pageNumber
                  ? FontWeight.w800
                  : FontWeight.normal,
              color: selectedPage == pageNumber
                  ? Color.fromARGB(189, 0, 0, 0)
                  : Color.fromARGB(255, 135, 135, 135)),
        ),
      ),
    );
  }
}
