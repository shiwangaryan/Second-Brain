// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_page_phone_email.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_signup_page_container.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/signup_page.dart';

class LoginSignupPageController extends GetxController {
  static LoginSignupPageController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentLoginPageIndex = 0.obs;

  //back button controller
  void backPageController() {
    currentLoginPageIndex.value = 0;
  }

  //continue & Signup with button
  void continueSignupController(index) {
    currentLoginPageIndex.value = index;
  }

  //all the widgets of authentication page
  final authenticationWidgets = [
    LoginSignupPageContainer(),
    SignupPageContainer(),
    SigninPageContainer(signMethod: 'Phone'),
    SigninPageContainer(signMethod: 'Email'),
  ];
}
