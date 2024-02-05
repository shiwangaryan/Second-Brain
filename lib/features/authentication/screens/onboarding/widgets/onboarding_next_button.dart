// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solution_challenge_app/features/authentication/controllers/on_boarding/on_boarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        (MediaQuery.of(context).platformBrightness) == Brightness.dark;

    return Positioned(
      right: 10.0,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: isDarkMode
              ? Color.fromARGB(255, 234, 234, 234)
              : Color(0XFF1F1F1F),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Icon(
            Iconsax.arrow_right_3,
            color: isDarkMode ? Color(0XFF1F1F1F) : Colors.white,
          ),
        ),
      ),
    );
  }
}
