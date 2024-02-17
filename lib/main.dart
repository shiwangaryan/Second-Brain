import 'package:flutter/material.dart';
import "package:solution_challenge_app/app.dart";
import 'package:solution_challenge_app/utils/logging/firebase_authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Authentication.initializeFirebase();
  runApp(const App());
}
