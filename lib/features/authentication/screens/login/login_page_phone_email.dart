// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_signup_page_container.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

class SigninPage extends StatelessWidget {
  SigninPage({super.key, required this.method});

  final String method;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: HelperFunctions.screenHeight(),
            width: HelperFunctions.screenWidth(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_page/gradient.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LoginSignupPageContainer(),
                SigninPageContainer(signMethod: method),
                // SignupPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            // ------- Star Icon & Back -------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Star(isDarkTheme: isDarkTheme),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginSignupPage()));
                  },
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
  });

  final bool isDarkTheme;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color.fromARGB(255, 247, 245, 245);
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
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF1A1A1A),
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
