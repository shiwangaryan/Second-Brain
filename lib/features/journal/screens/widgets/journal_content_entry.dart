import 'package:flutter/material.dart';

Widget journalContentEntry(TextEditingController contentController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: TextField(
      controller: contentController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'write about it',
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.5),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
