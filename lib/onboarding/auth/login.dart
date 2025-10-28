import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/onboarding/auth/registration.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/util/snack_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must have uppercase,lowercase,number, and 6+ chars';
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final firebaseAuth = FirebaseAuth.instance;
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
        AppConstans.showSnackBar(context, message: 'successful logedin');
      } on FirebaseException catch (e) {
        if (e.code == 'invalid-credential') {
          AppConstans.showSnackBar(context,
              message: 'incorrect email and password');
        } else {
          AppConstans.showSnackBar(context, message: e.toString());
        }
      } catch (error) {
        AppConstans.showSnackBar(context, message: error.toString());
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset('assets/images/olxLogo.png', height: 50.h),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 213, 213, 213),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 10),
                        ),
                      ]),
                      child: TextFormField(
                        controller: emailController,
                        validator: _validateEmail,
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(
                                color: Colors.lightBlue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 213, 213, 213),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 10),
                        ),
                      ]),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(
                                color: Colors.lightBlue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 34.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have account? ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () {
                               Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()),
                                (route) => false, );
                            },
                            child: const Text(
                              "Create One",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // loading overlay
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color:
                      const Color.fromARGB(255, 34, 139, 238).withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
