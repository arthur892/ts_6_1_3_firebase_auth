import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authInstance = FirebaseAuth.instance;

  String error = "";
  String welcomeMessage = "Willkommen";

  Future<void> loginUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
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
      setState(() {
        welcomeMessage = "Ausgeloggt";
      });
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
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
                  const SizedBox(height: 200, width: 200, child: Placeholder()),
            ),
            Text(
              welcomeMessage,
              //style: Theme.of(context).textTheme.displayMedium,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.amber),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      clearError();
                      loginUser();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )),
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
        ));
  }
}
