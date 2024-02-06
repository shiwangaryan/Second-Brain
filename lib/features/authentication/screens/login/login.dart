// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_page_phone_email.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/signup_page.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_signup_page_container.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                // LoginPageContainer(signMethod: 'Email'),
                SignupPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
