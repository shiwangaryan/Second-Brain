import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: [
        Container(
          color: Colors.black,
        ),
        Container(
          color: Colors.black,
        ),

        Container(
          color: Colors.black,
        ),
        Container(
          color: Colors.black,
        ),

        // NavigationDestination(icon: icon, label: label),
      ]),
    );
  }
}
