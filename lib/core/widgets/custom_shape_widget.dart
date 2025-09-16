import 'package:flutter/material.dart';

class CustomShapeWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, size.height - 16,
        size.width - 16, size.height - 16);

    path.cubicTo(size.width, size.height - 16, size.width * 0, size.height - 16,
        16, size.height - 16);

    path.cubicTo(
        size.width * 0, size.height - 16, 0, size.height, 0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
