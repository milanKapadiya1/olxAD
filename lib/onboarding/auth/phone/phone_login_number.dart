import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/onboarding/auth/phone/otp_screen.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/util/app_theme.dart';

class PhoneLoginNumber extends StatefulWidget {
  const PhoneLoginNumber({super.key});

  @override
  State<PhoneLoginNumber> createState() => _PhoneLoginNumberState();
}

class _PhoneLoginNumberState extends State<PhoneLoginNumber> {
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;
  bool _isButtonEnable = false;
  Future<void> _phoneLogin() async {
    // take number form textfield

    final String phoneNumber = "+91${_phoneController.text.trim()}";
    final instance = FirebaseAuth.instance;
    setState(() {
      isLoading = true;
    });
    // now trigger firebase verification

    await instance.verifyPhoneNumber(
        timeout: Duration(seconds: 30),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential userCredential =
                await instance.signInWithCredential(credential);
            if (userCredential.user != null) {
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          } on FirebaseAuthException catch (e) {
            debugPrint('faild ${e.message}');
          }
        },
        verificationFailed: (FirebaseException excptions) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Failed: ${excptions.message}'),
              backgroundColor: const Color.fromARGB(255, 210, 89, 80),
            ),
          );
        },
        codeSent: (String verificationID, int? resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationId: verificationID,
                      )));
          // final String id = verificationID;
          // debugPrint(id);
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: Text(
            'Login',
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20.sp) ??
                TextStyle(fontSize: 20.sp, color: AppTheme.textPrimary),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child:
                Divider(height: 1.h, color: Colors.grey.shade300, thickness: 1),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              CircleAvatar(
                radius: 30.r,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(Icons.person,
                    size: 36.sp, color: theme.colorScheme.primary),
              ),
              SizedBox(height: 18.h),
              Text(
                'Enter your phone number',
                style:
                    theme.textTheme.displaySmall?.copyWith(fontSize: 28.sp) ??
                        TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                "We'll send you a verification code on the same number.",
                style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.textSecondary) ??
                    TextStyle(color: AppTheme.textSecondary, fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              Text('Country', style: theme.textTheme.titleMedium),
              SizedBox(height: 8.h),
              Row(
                children: [
                  SizedBox(
                    width: 70.w,
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(text: '+91'),
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        border: const UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: theme.colorScheme.primary)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: theme.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: theme.colorScheme.primary)),
                        ),
                        onChanged: (v) {
                          bool shouldEnable = v.length == 10;
                          if (_isButtonEnable != shouldEnable) {
                            setState(() {
                              _isButtonEnable = shouldEnable;
                            });
                          }
                        }),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnable
                      ? () {
                          _phoneLogin();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text('Next', style: theme.textTheme.labelLarge),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
