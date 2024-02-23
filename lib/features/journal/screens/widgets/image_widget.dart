import 'dart:io';

import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    super.key,
    required this.imageFile,
  });

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(imageFile),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
