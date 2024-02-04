import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variables

  //update current index when page scrolls
  void updatePageIndicator(index) {}

  //update index & jump to next page
  void nextPage(index) {}

  //update index & move to dot specified page
  void dotSpecifiedPage() {}

  //update index & jump to last page
  void skipPage() {}
}
