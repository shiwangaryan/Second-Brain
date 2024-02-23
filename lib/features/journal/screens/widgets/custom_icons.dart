import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressFunc,
    required this.icon,
    required this.size,
  });

  final void Function() onPressFunc;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressFunc,
      icon: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
