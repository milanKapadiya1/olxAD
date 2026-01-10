import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olxad/onboarding/auth/registration.dart';
import 'package:olxad/screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Fast-path: if a user is already available synchronously, show Home immediately.
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeScreen();
    }

    // Otherwise listen for auth state changes (covers async restore and sign-in/out).
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return const HomeScreen();
        }

        return const RegistrationScreen();
      },
    );
  }
}
