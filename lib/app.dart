// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:solution_challenge_app/features/authentication/screens/on_boarding.dart";


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: OnBoardingScreen(),
    );
  }
}
