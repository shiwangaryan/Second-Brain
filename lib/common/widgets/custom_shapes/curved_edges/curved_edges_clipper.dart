import 'package:flutter/material.dart';

class RoundedBorderShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size childsize) {
    var path = Path();

    path.lineTo(0, childsize.height);

    final firstCurveFirstPoint = Offset(0, childsize.height - 20);
    final firstCurveLastPoint = Offset(30, childsize.height - 20);
    path.quadraticBezierTo(firstCurveFirstPoint.dx, firstCurveFirstPoint.dy,
        firstCurveLastPoint.dx, firstCurveLastPoint.dy);

    final secondCurveFirstPoint = Offset(30, childsize.height - 20);
    final secondCurveLastPoint =
        Offset(childsize.width - 30, childsize.height - 20);
    path.quadraticBezierTo(secondCurveFirstPoint.dx, secondCurveFirstPoint.dy,
        secondCurveLastPoint.dx, secondCurveLastPoint.dy);

    final thirdCurveFirstPoint = Offset(childsize.width, childsize.height - 20);
    final thirdCurveLastPoint = Offset(childsize.width, childsize.height);
    path.quadraticBezierTo(thirdCurveFirstPoint.dx, thirdCurveFirstPoint.dy,
        thirdCurveLastPoint.dx, thirdCurveLastPoint.dy);

    path.lineTo(childsize.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
