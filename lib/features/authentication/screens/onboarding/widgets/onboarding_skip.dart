import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/authentication/controllers/on_boarding/on_boarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        (MediaQuery.of(context).platformBrightness) == Brightness.dark;
    return Positioned(
        top: kToolbarHeight,
        right: 20.0,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: Text(
            'Skip',
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}
