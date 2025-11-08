import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/user_data.dart';
import 'package:olxad/onboarding/auth/login.dart';
import 'package:olxad/screens/home_page.dart';
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
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must have uppercase,lowercase,number, and 6+ chars';
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
          MaterialPageRoute(builder: (_) => const HomePage()),
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
      final googleSignInAccount = await googleSignIn.authenticate(

      );

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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
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
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                                color: Colors.lightBlue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
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
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _googleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Sign Up with google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                            "Already have account? ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Login",
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
