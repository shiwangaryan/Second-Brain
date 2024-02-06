// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class LoginPageContainer extends StatelessWidget {
  const LoginPageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        (MediaQuery.of(context).platformBrightness) == Brightness.dark;

    return Container(
      height: HelperFunctions.screenHeight() * 0.53,
      width: HelperFunctions.screenWidth() * 0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: isDarkTheme ? Color(0XFF1A1A1A) : Color(0XFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // ------- Star Icon -------
            Star(isDarkTheme: isDarkTheme),
            //
            // ------- Get Started -------
            Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: isDarkTheme ? Color(0XFFFFFFFF) : Color(0XFF1A1A1A),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 15),
              child: Text(
                "Empowering you, welcome to a brighter journey with our app",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: isDarkTheme
                      ? Color.fromARGB(255, 173, 173, 173)
                      : Color(0XFF707070),
                ),
              ),
            ),
            //
            // ------- Continue Button -------
            TextButton(
              isDarkTheme: isDarkTheme,
              text: 'Continue with Phone',
              lightColor: Color(0XFF1A1A1A),
              darkColor: Color(0XFFFFFFFF),
            ),
            TextButton(
              isDarkTheme: isDarkTheme,
              text: 'Continue with Email',
              lightColor: Color(0XFFEDEDED),
              darkColor: Color(0XFF1A1A1A),
            ),
          ],
        ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({
    super.key,
    required this.isDarkTheme,
    required this.text,
    required this.lightColor,
    required this.darkColor,
  });

  final bool isDarkTheme;
  final String text;
  final Color lightColor;
  final Color darkColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: isDarkTheme ? darkColor : lightColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: isDarkTheme ? lightColor : darkColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// container star
class Star extends StatelessWidget {
  const Star({super.key, required this.isDarkTheme});
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    String starIcon = isDarkTheme
        ? 'assets/images/login_page/star_white.png'
        : 'assets/images/login_page/star_black.png';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkTheme
              ? Color.fromARGB(255, 48, 48, 48)
              : Color.fromARGB(255, 243, 242, 242),
        ),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              starIcon,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}

// Get Started Info
