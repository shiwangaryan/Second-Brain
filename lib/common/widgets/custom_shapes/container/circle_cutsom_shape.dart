import 'package:flutter/material.dart';

class CircularShape extends StatelessWidget {
  const CircularShape({
    super.key,
    this.width = 400,
    this.height = 400,
    this.shapeColor = const Color.fromARGB(255, 60, 158, 255),
    this.radius = 400,
    this.child,
  });

  final double? width;
  final double? height;
  final double radius;
  final Color? shapeColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: shapeColor,
      ),
    );
  }
}
