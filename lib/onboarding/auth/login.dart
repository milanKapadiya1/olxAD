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
        backgroundColor: const Color.fromARGB(255, 248, 248, 250),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      // Logo
                      Center(
                        child: Image.asset('assets/images/olxLogo.png', height: 48.h),
                      ),
                      SizedBox(height: 48.h),
                      // Title
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 25, 25, 35),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Subtitle
                      Text(
                        'Sign in to your account to continue',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromARGB(255, 120, 120, 130),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 36.h),
                      // Email Field
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 25, 25, 35),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: emailController,
                        validator: _validateEmail,
                        decoration: InputDecoration(
                          hintText: "you@example.com",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 150, 150, 160),
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: const Color.fromARGB(255, 100, 100, 110),
                            size: 20.w,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 220, 220, 225),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 59, 130, 246),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 239, 68, 68),
                              width: 1.5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 239, 68, 68),
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(height: 22.h),
                      // Password Field
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 25, 25, 35),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          hintText: "••••••••",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 150, 150, 160),
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: const Color.fromARGB(255, 100, 100, 110),
                            size: 20.w,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 220, 220, 225),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 59, 130, 246),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 239, 68, 68),
                              width: 1.5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 239, 68, 68),
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(height: 28.h),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 59, 130, 246),
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 100, 100, 110),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegistrationScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color.fromARGB(255, 59, 130, 246),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
            // loading overlay
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 59, 130, 246),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
