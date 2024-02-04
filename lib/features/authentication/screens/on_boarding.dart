// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
              Column(
                children: [
                  Image(
                      height: HelperFunctions.screenHeight() * 0.8,
                      width: HelperFunctions.screenWidth() * 0.6,
                      image: const AssetImage(Images.onBoardingJournal)),
                  Text(OnBoardingText.onBoardingTitle1,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 16,
                  ), // to add space between title and subtitle
                  Text(
                    OnBoardingText.onBoardingSubTitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
