import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/authentication/screens/login/login_signup_page_container.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //update current index when page scrolls
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //update index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 4) {
      Get.to(LoginSignupPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //update index & move to dot specified page
  void dotSpecifiedPage(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //update index & jump to last page
  void skipPage() {
    currentPageIndex.value = 4;
    pageController.jumpToPage(4);
  }
}
