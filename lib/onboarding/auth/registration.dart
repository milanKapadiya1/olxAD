import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/bloc/auth/auth_bloc.dart'; // Import Bloc
import 'package:olxad/bloc/auth/auth_even.dart'; // Import Event
import 'package:olxad/bloc/auth/auth_state.dart'; // Import State
import 'package:olxad/onboarding/auth/login.dart';
import 'package:olxad/onboarding/auth/phone/phone_login_number.dart';
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

  // 1. DISPOSE CONTROLLERS (Very Important!)
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 2. UI VALIDATORS (Keep these here)
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,20}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must have 1 upper, lower, number, symbol & 6-20 chars';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 3. PROVIDE THE BLOC
    return BlocProvider(
      create: (context) => RegestrationBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 248, 248, 250),

          // 4. CONSUME STATE
          body: BlocConsumer<RegestrationBloc, RegestrationState>(
            listener: (context, state) {
              if (state is RegestrationSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
                AppConstans.showSnackBar(context,
                    message: 'Account created successfully', isSuccess: true);
              } else if (state is RegestrationFailure) {
                AppConstans.showSnackBar(context,
                    message: state.error, isSuccess: false);
              }
            },
            builder: (context, state) {
              return Stack(
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
                            Center(
                                child: Image.asset('assets/images/olxLogo.png',
                                    height: 48.h)),
                            SizedBox(height: 44.h),
                            Text('Create Account',
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromARGB(255, 25, 25, 35))),
                            SizedBox(height: 8.h),
                            Text('Join us to explore amazing deals',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromARGB(
                                        255, 120, 120, 130),
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 36.h),

                            // Email
                            Text('Email Address',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 10.h),
                            TextFormField(
                              controller: emailController,
                              validator: _validateEmail,
                              decoration: InputDecoration(
                                hintText: "you@example.com",
                                prefixIcon:
                                    Icon(Icons.email_outlined, size: 20.w),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),
                            ),
                            SizedBox(height: 22.h),

                            // Password
                            Text('Password',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 10.h),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: _validatePassword,
                              decoration: InputDecoration(
                                hintText: "••••••••",
                                prefixIcon:
                                    Icon(Icons.lock_outline, size: 20.w),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),
                            ),
                            SizedBox(height: 28.h),

                            // SUBMIT BUTTON
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Trigger Bloc Event
                                    context.read<RegestrationBloc>().add(
                                          Submmited(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 59, 130, 246)),
                                child: Text("Create Account",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),

                            // ... Other buttons (Mobile Login, Login Link) ...
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneLoginNumber()));
                                },
                                child: Text("Mobile Login"),
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // GOOGLE BUTTON
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Trigger Bloc Event
                                  context
                                      .read<RegestrationBloc>()
                                      .add(GoogleSignIN());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.g_mobiledata),
                                    Text("Sign Up with Google"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 24,),
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
                                child: Text('Already have accoutn? Login'))
                            // ... Login Link ...
                          ],
                        ),
                      ),
                    ),
                  ),

                  // LOADING INDICATOR
                  if (state is RegestrationLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
