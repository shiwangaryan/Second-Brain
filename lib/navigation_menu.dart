import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solution_challenge_app/features/chatbot/screen/chatscreen.dart';
import 'package:solution_challenge_app/features/home/screens/home/home.dart';
import 'package:solution_challenge_app/features/music/screen/music.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigatorMenuController());

    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: Obx(
            () => NavigationBar(
                backgroundColor: Colors.transparent,
                height: 60,
                elevation: 0,
                selectedIndex: controller.selectionindex.value,
                onDestinationSelected: (index) =>
                    controller.selectionindex.value = index,
                destinations: const [
                  // home
                  NavigationDestinationWidget(icon: Iconsax.home),
                  // music
                  NavigationDestinationWidget(icon: Iconsax.music),
                  // add journal button
                  NavigationDestinationWidget(icon: Iconsax.add5),
                  // medication
                  NavigationDestinationWidget(icon: Icons.medication),
                ]),
          ),
          body: Obx(() => controller.screen[controller.selectionindex.value]),
        ),
        Positioned(
          bottom: 90,
          right: 26,
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(60),
            ),
            child: IconButton(
              onPressed: () => Get.to(const ChatScreen()),
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NavigatorMenuController extends GetxController {
  // variables
  final Rx<int> selectionindex = 0.obs;

  // screens
  final screen = [
    const HomeScreen(),
    const MusicPage(),
    Container(color: Colors.red),
    Container(color: Colors.green),
  ];
}

// ----- all widgets below ------
//
class NavigationDestinationWidget extends StatelessWidget {
  const NavigationDestinationWidget({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: NavigationDestination(icon: Icon(icon), label: ''),
    );
  }
}
