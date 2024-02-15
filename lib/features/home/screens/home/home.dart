import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:solution_challenge_app/features/home/screens/home/widgets/image_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const circleBgColor = Color.fromARGB(255, 195, 225, 255);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              circleBgColor: circleBgColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CustomAppBar(
                      title: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Shiwang',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/appbar/shiwang_profile_photo.jpg'),
                                  fit: BoxFit.cover,
                                )))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: Text(
                      'Memories',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 25.0, right: 20, left: 20),
                    child: ImageCarousel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
