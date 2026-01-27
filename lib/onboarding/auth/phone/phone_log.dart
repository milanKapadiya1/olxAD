import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/onboarding/auth/phone/phone_login_number.dart';

class PhoneLog extends StatefulWidget {
  const PhoneLog({super.key});

  @override
  State<PhoneLog> createState() => _PhoneLogState();
}

class _PhoneLogState extends State<PhoneLog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.cancel_rounded,
                    size: 24,
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.help_outline_outlined,
                        size: 24,
                        color: Color.fromARGB(255, 54, 54, 54),
                      ),
                      SizedBox(width: 8.w),
                      const Text('Help', style: TextStyle(color: Color.fromARGB(255, 54, 54, 54))),
                    ],
                  )
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1155F0),
              ),
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1155F0),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneLoginNumber()));
                      },
                      icon: const Icon(Icons.smartphone, size: 20),
                      label: Text(
                        'Continue with Phone',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  const Text('OR', style: TextStyle(color: Colors.white)),

                  SizedBox(height: 12.h),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Login with Email',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                      children: [
                        const TextSpan(text: 'If you continue, you are accepting\n'),
                        TextSpan(
                          text: 'OLX Terms and Conditions and Privacy Policy',
                          style: const TextStyle(decoration: TextDecoration.underline, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}