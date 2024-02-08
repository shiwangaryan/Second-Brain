import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class OnBoardingPageColumn extends StatelessWidget {
  const OnBoardingPageColumn({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: HelperFunctions.screenWidth() * 0.08,
          left: HelperFunctions.screenWidth() * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: HelperFunctions.screenHeight() * 0.37,
            width: HelperFunctions.screenWidth() * 0.37,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16,
          ), // to add space between title and subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
