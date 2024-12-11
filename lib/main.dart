import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ts_6_1_3_firebase_auth/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final authInstance = FirebaseAuth.instance;

  String error = "";
  String welcomeMessage = "Willkommen";

  Future<void> loginUser() async {
    try {
      await authInstance.signInWithEmailAndPassword(
          email: "test@test.de", password: "123456");
      String? user = getUser()!.email;
      welcomeMessage = "Hallo $user";
      setState(() {});
    } catch (e) {
      dev.log("Login: $e");
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> logout() async {
    try {
      await authInstance.signOut();
    } catch (e) {
      dev.log("Logout: $e");
      error = e.toString();
    }
  }

  clearError() {
    setState(() {
      error = "";
    });
  }

  User? getUser() {
    return authInstance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Placeholder(),
              Text(
                welcomeMessage,
                style: const TextStyle(fontSize: 24, color: Colors.amber),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        clearError();
                        loginUser();
                      },
                      child: const Text("Login")),
                  ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      child: const Text("Logout")),
                ],
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              )
              //FutureBuilder(future: getUser(), builder: builder)
            ],
          )),
    );
  }
}
