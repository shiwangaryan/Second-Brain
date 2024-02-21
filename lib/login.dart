import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/navigation_menu.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: HelperFunctions.screenHeight(),
            width: HelperFunctions.screenWidth(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_page/gradient.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // Add google login Button
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: HelperFunctions.screenHeight() * 0.4,
                  width: HelperFunctions.screenWidth(),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/login_page/google-logo-9808.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Please Login to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              var usercred =
                                  await GoogleAuth().signInWithGoogle();
                              var user = usercred.user;
                              var displayName = user!.displayName;
                              var email = user.email;
                              var photoUrl = user.photoURL;
                              log(displayName.toString());
                              log(email.toString());
                              log(photoUrl.toString());
                              Get.snackbar('Welcome:', 'Hello $displayName');
                              var box = Hive.box('user');
                              box.put('name', displayName);
                              box.put('email', email);
                              box.put('pfp', photoUrl);
                              box.put('user', user.uid);
                              Get.offAll(() => const NavigationMenu());
                            } catch (e) {
                              Get.snackbar('Error:', e.toString());
                            } finally {
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: isloading
                                  ? [
                                      const CircularProgressIndicator(),
                                    ]
                                  : const [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/login_page/google-logo-9808.png'),
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Login with Google'),
                                    ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
