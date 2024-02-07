// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/authentication/controllers/login_signup/login_signup_pages_controller.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(() =>
                  LoginSignupPageController.instance.authenticationWidgets[
                      LoginSignupPageController
                          .instance.currentLoginPageIndex.value]),
            ),
          ),
        ],
      ),
    );
  }
}
