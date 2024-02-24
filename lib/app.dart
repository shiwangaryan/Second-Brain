import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:solution_challenge_app/login.dart";
import "package:solution_challenge_app/navigation_menu.dart";
import "package:solution_challenge_app/utils/theme/theme.dart";
import 'package:hive_flutter/hive_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CheckLogin(),
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    var user = box.get('user');
    print('user: $user');
    if (user == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const LoginPage());
      });
    } else if (user != null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const NavigationMenu());
      });
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
