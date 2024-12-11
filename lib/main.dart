import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ts_6_1_3_firebase_auth/firebase_options.dart';
import 'package:ts_6_1_3_firebase_auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
    );
  }
}
