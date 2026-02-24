import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/util/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olxad/model/user_data.dart';

class OtpScreen extends StatefulWidget {
  final String? verificationId;
  const OtpScreen({super.key, this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String smsCode = "";
  bool isLoading = false;

  Future<void> verifyOtp() async {
    if (smsCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid OTP")),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId ?? '', smsCode: smsCode);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        final user = userCredential.user!;
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        final userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          final newUser = UserDetails(
            uid: user.uid,
            email: user.email,
            phoneNumber: user.phoneNumber,
            userName: '',
          );
          await userDocRef.set(newUser.toJson());
        }

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'invalid-verification-code') {
        message = "Invalid OTP. Please try again.";
      }if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppTheme.textPrimary,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // Header Icon/Illustration
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.lock_person_outlined,
                    size: 56.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // Title
              Text(
                "Verification Code",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 12.h),

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "We have sent the verification code to your mobile number",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Fields
              OtpTextField(
                keyboardType: TextInputType.number,
                autoFocus: true,
                numberOfFields: 6,
                borderColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                focusedBorderColor: AppTheme.primaryColor,
                showFieldAsBox: true,
                fieldWidth: 47.w,
                borderRadius: BorderRadius.circular(12.r),
                textStyle: GoogleFonts.outfit(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (String verificationCode) {
                  setState(() {
                    smsCode = verificationCode;
                  });
                },
              ),
              SizedBox(height: 50.h),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    isLoading ? null : verifyOtp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 5,
                    shadowColor: AppTheme.primaryColor.withValues(alpha: 0.3),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 24.h),

              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Did not receive code? ",
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement resend logic
                    },
                    child: Text(
                      "Resend New Code",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
