// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solution_challenge_app/utils/constants/image_strings.dart';
import 'package:solution_challenge_app/utils/constants/text_strings.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ---- Horizontal Page Scroll ----
          PageView(
            children: [
              OnBoardingPageColumn(),
            ],
          )
        ],
      ),
    );
  }
}

class OnBoardingPageColumn extends StatelessWidget {
  const OnBoardingPageColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27),
      child: Column(
        children: [
          SvgPicture.asset(
            Images.onBoardingJournal,
            height: HelperFunctions.screenHeight() * 0.6,
            width: HelperFunctions.screenWidth() * 0.8,
          ),
          Text(OnBoardingText.onBoardingTitle1, textAlign: TextAlign.center),
          const SizedBox(
            height: 16,
          ), // to add space between title and subtitle
          Text(
            OnBoardingText.onBoardingSubTitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
