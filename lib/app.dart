// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:solution_challenge_app/features/authentication/screens/login/login.dart";
import 'package:solution_challenge_app/features/authentication/screens/onboarding/on_boarding.dart';
import "package:solution_challenge_app/utils/theme/theme.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
