import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:solution_challenge_app/app.dart";
import 'package:solution_challenge_app/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('user');
  await Hive.openBox('memories');
  await Hive.openBox('medicines');
  await Hive.openBox('journal');
  await Hive.openBox('calendar');
  runApp(const App());
}
