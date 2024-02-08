import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/authentication/controllers/on_boarding/on_boarding_controller.dart';
import 'package:solution_challenge_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:solution_challenge_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:solution_challenge_app/features/authentication/screens/onboarding/widgets/onboarding_pages.dart';
import 'package:solution_challenge_app/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:solution_challenge_app/utils/constants/image_strings.dart';
import 'package:solution_challenge_app/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // ---- Horizontal Page Scroll ----
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPageColumn(
                image: Images.onBoardingJournal,
                title: OnBoardingText.onBoardingTitle1,
                subtitle: OnBoardingText.onBoardingSubTitle1,
              ),
              OnBoardingPageColumn(
                image: Images.onBoardingRoutine,
                title: OnBoardingText.onBoardingTitle2,
                subtitle: OnBoardingText.onBoardingSubTitle2,
              ),
              OnBoardingPageColumn(
                image: Images.onBoardingMedication,
                title: OnBoardingText.onBoardingTitle3,
                subtitle: OnBoardingText.onBoardingSubTitle3,
              ),
              OnBoardingPageColumn(
                image: Images.onBoardingMusic,
                title: OnBoardingText.onBoardingTitle4,
                subtitle: OnBoardingText.onBoardingSubTitle4,
              ),
              OnBoardingPageColumn(
                image: Images.onBoardingChatbot,
                title: OnBoardingText.onBoardingTitle5,
                subtitle: OnBoardingText.onBoardingSubTitle5,
              ),
            ],
          ),
          // skip button
          const OnBoardingSkip(),
          // dot navigations
          const OnBoardingDotNavigation(),
          // circular next button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
