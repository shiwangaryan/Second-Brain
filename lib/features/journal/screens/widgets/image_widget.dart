import 'dart:io';

import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    super.key,
    required this.imageFile,
  });

  final String imageFile;

  @override
  Widget build(BuildContext context) {
    final path = File(imageFile);
    return Container(
      width: 380,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(path),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
