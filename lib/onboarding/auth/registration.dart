import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/user_data.dart';
import 'package:olxad/onboarding/auth/login.dart';
import 'package:olxad/onboarding/auth/phone/phone_login_number.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/screens/home_screen.dart';
import 'package:olxad/util/snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

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
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,20}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must have 1 upper, lower, number, symbol & 6-20 chars';
    }
    return null;
  }

  Future<void> _storeUserData({
    required UserDetails userDetails,
  }) async {
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection('/users')
        .doc(userDetails.uid)
        .set(userDetails.toJson());
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      setState(() {
        isLoading = true;
      });
      try {
        final userCradentionl = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCradentionl.user == null) {
          throw Exception('user data is null');
        }
        await _storeUserData(
            userDetails: UserDetails(
          uid: userCradentionl.user!.uid,
          location: '',
          email: userCradentionl.user!.email ?? emailController.text.trim(),
        ));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        AppConstans.showSnackBar(
          context,
          message: 'Account created successfully',
          isSuccess: true,
        );
      } on FirebaseAuthException catch (error) {
        if (!mounted) return;
        String message = 'Registration failed';
        if (error.code == 'weak-password') {
          message = 'Weak password';
        } else if (error.code == 'email-already-in-use') {
          message = 'Email is already in use';
        } else if (error.code == 'invalid-email') {
          message = 'Invalid email address';
        } else {
          message = error.message ?? message;
        }
        AppConstans.showSnackBar(context, message: message, isSuccess: false);
        debugPrint('FirebaseAuthException: ${error.code} ${error.message}');
      } catch (e) {
        if (!mounted) return;
        AppConstans.showSnackBar(context,
            message: e.toString(), isSuccess: false);
        debugPrint('Registration error: $e');
      } finally {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _googleSignIn() async {
    setState(() {
      isLoading = true; // Step 1: Start loading animation or disable button
    });

    try {
      await googleSignIn.initialize();

      // Step 3: Authenticate user (open Google account chooser)
      final googleSignInAccount = await googleSignIn.authenticate();

      // Step 5: Get authentication tokens from Google
      final googleAuth = googleSignInAccount.authentication;

      // Step 6: Create Firebase credential using Google token
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Step 7: Sign in to Firebase using Google credential
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithCredential(credential);

      final user = firebaseAuth.currentUser;
      if (user != null) {
        final userDetais = UserDetails(
          uid: user.uid,
          email: user.email,
        );
        await _storeUserData(userDetails: userDetais);
      }

      // Step 8: Ensure widget is still mounted before navigation
      if (!mounted) return;

      // Step 9: Go to HomePage after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Step 10: Show any errors
      if (mounted) {
        AppConstans.showSnackBar(context, message: e.toString());
      }
    } finally {
      // Step 11: Stop loading spinner in all cases
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                        child: Image.asset('assets/images/olxLogo.png',
                            height: 48.h),
                      ),
                      SizedBox(height: 44.h),
                      // Title
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 25, 25, 35),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Subtitle
                      Text(
                        'Join us to explore amazing deals',
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.h),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.h),
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
                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 130, 246),
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                       SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneLoginNumber(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 130, 246),
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Mobile Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h,),

                      // Google Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _googleSignIn,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 220, 220, 225),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                color: const Color.fromARGB(255, 59, 130, 246),
                                size: 20.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 59, 130, 246),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
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
                                  builder: (context) => const Login(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Login",
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
