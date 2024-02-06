// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_page_phone_email.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class LoginSignupPageContainer extends StatelessWidget {
  const LoginSignupPageContainer({
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
        padding: const EdgeInsets.symmetric(horizontal: 23),
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
              darkColor: Color.fromARGB(255, 239, 237, 237),
            ),
            TextButton(
              isDarkTheme: isDarkTheme,
              text: 'Continue with Email',
              lightColor: Color.fromARGB(255, 247, 245, 245),
              darkColor: Color.fromARGB(255, 41, 41, 41),
            ),
            //
            // ----- last row -------
            Row(
              children: [
                //
                // ------- Icon Button -------
                Expanded(
                  child: IconButton(
                    isDarkTheme: isDarkTheme,
                    logo: isDarkTheme
                        ? 'assets/images/login_page/google_white.png'
                        : 'assets/images/login_page/google_black.png',
                    lightColor: Color.fromARGB(255, 247, 245, 245),
                    darkColor: Color.fromARGB(255, 41, 41, 41),
                  ),
                ),
                //
                // ------- Gap inbetween -------
                SizedBox(width: 6),
                //
                // ------- Sign Up Button -------
                Expanded(
                  child: TextButton(
                    isDarkTheme: isDarkTheme,
                    text: "Sign Up?",
                    lightColor: Color.fromARGB(255, 247, 245, 245),
                    darkColor: Color.fromARGB(255, 41, 41, 41),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//
// ----- all the widgets used below ------
//
// icon button
class IconButton extends StatelessWidget {
  const IconButton({
    super.key,
    required this.isDarkTheme,
    required this.logo,
    required this.lightColor,
    required this.darkColor,
  });

  final bool isDarkTheme;
  final String logo;
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
                elevation: 0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Image.asset(
                  logo,
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// text button
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
              onPressed: () =>
                  {Get.to(() => LoginPageContainer(signMethod: 'Email'))},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: isDarkTheme ? darkColor : lightColor,
                elevation: 0,
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
      padding: const EdgeInsets.only(top: 23),
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
