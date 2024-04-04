import 'package:flutter/material.dart';

class BookmarkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(
        size.width / 2, size.height * 0.7); // The "bookmark" indentation
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 1.25, 0, size.width - 10, 0);
    path.lineTo(10, 0); // Start of top left curve
    path.quadraticBezierTo(0, 0, 0, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyBookmarkWidget extends StatefulWidget {
  @override
  State<MyBookmarkWidget> createState() => _MyBookmarkWidgetState();
}

class _MyBookmarkWidgetState extends State<MyBookmarkWidget> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BookmarkClipper(),
      child: Container(
        color: isClicked
            ? Color(0xFFF7B539).withOpacity(0.8)
            : Color(0xFF514F4F).withOpacity(0.8),
        width: MediaQuery.of(context).size.width *
            0.078, // Sets width for bookmark
        height: MediaQuery.of(context).size.height *
            0.05, // Sets height for bookmark
        child: Center(
          child: IconButton(
            icon: Icon(
              isClicked ? Icons.check : Icons.add,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                isClicked = !isClicked;
              });
            },
          ),
        ),
      ),
    );
  }
}
