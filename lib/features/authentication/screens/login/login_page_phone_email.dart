// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solution_challenge_app/features/authentication/controllers/login_signup/login_signup_pages_controller.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class SigninPageContainer extends StatelessWidget {
  const SigninPageContainer({
    super.key,
    required this.signMethod,
  });

  final String signMethod;

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        (MediaQuery.of(context).platformBrightness) == Brightness.dark;
    final Color labelTextIconColor = Color.fromARGB(255, 133, 132, 132);
    final Color otpContainerColor = Color.fromARGB(255, 247, 245, 245);
    final Color firstContainerColor = Color.fromARGB(255, 41, 41, 41);
    final controller = Get.put(LoginSignupPageController());


    return Container(
      height: HelperFunctions.screenHeight() * 0.6,
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
            // ------- Star Icon & Back -------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Star(isDarkTheme: isDarkTheme),
                TextButton(
                  onPressed: () =>
                      controller.backPageController(),
                  child: Text(
                    'Back',
                    style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
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
            // ------- Form -------
            Form(
              child: Column(
                children: [
                  //
                  //-------- phone number --------
                  Container(
                    decoration: BoxDecoration(
                      color: firstContainerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            (signMethod == 'Email')
                                ? Icons.mail
                                : Icons.phone_iphone_rounded,
                            color: labelTextIconColor,
                          ),
                          labelText: signMethod,
                          labelStyle: TextStyle(color: labelTextIconColor)),
                    ),
                  ),
                  //
                  //-------- gap --------
                  SizedBox(height: 8),
                  //
                  //-------- otp --------
                  Container(
                    decoration: BoxDecoration(
                      color: otpContainerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Iconsax.password_check,
                          color: labelTextIconColor,
                        ),
                        labelText: 'OTP',
                        labelStyle: TextStyle(color: labelTextIconColor),
                      ),
                    ),
                  ),
                  //
                  //-------- checkbox & remember me --------
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Checkbox(
                              value: true,
                              onChanged: (value) {},
                              activeColor: isDarkTheme
                                  ? otpContainerColor
                                  : firstContainerColor,
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                        RemeberText(
                            isDarkTheme: isDarkTheme, text: 'Remember Me'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //
            // ----- last row -------
            Row(
              children: [
                //
                // ------- Icon Button -------
                Expanded(
                  child: LoginTextButton(
                    isDarkTheme: isDarkTheme,
                    text: 'Send OTP',
                    bgColor: otpContainerColor,
                    fontsize: 15,
                    textColor: firstContainerColor,
                  ),
                ),
                //
                // ------- Gap inbetween -------
                SizedBox(width: 6),
                //
                // ------- Sign Up Button -------
                Expanded(
                  child: LoginTextButton(
                    isDarkTheme: isDarkTheme,
                    text: "Sign Up?",
                    bgColor: otpContainerColor,
                    textColor: firstContainerColor,
                    fontsize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            //
            // ------- Sign In button
            Row(
              children: [
                Expanded(
                    child: LoginTextButton(
                  isDarkTheme: isDarkTheme,
                  text: 'Sign In',
                  bgColor: firstContainerColor,
                  textColor: Colors.white,
                  fontsize: 18,
                ))
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
// --------- remember text
class RemeberText extends StatelessWidget {
  const RemeberText({
    super.key,
    required this.isDarkTheme,
    required this.text,
  });

  final bool isDarkTheme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
    );
  }
}

//
// text button
class LoginTextButton extends StatelessWidget {
  const LoginTextButton({
    super.key,
    required this.isDarkTheme,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.fontsize,
  });

  final bool isDarkTheme;
  final String text;
  final Color bgColor;
  final Color textColor;
  final double fontsize;

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
                backgroundColor: bgColor,
                elevation: 0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: fontsize,
                    fontWeight: FontWeight.w400,
                    color: textColor,
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
