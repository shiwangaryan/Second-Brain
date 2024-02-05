// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:solution_challenge_app/features/authentication/controllers/on_boarding/on_boarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller= OnBoardingController.instance;
    bool isDarkMode =
        (MediaQuery.of(context).platformBrightness) == Brightness.dark;
    return Positioned(
      bottom: kBottomNavigationBarHeight * 1.4,
      left: 35,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotSpecifiedPage,
        count: 5,
        effect: ExpandingDotsEffect(
          activeDotColor: isDarkMode ? Colors.white : Color(0XFF1F1F1F),
          dotHeight: 6,
          dotWidth: 12,
        ),
      ),
    );
  }
}
