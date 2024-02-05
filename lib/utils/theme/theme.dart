import 'package:flutter/material.dart';
import 'package:solution_challenge_app/utils/theme/custom_themes/textThemes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue[600],
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue[600],
    scaffoldBackgroundColor: const Color(0xFF1F1F1F),
    textTheme: AppTextTheme.darkTextTheme,
  );
}
