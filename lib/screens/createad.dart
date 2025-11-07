import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Createad extends StatelessWidget {
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  Createad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Create ad for : $userEmail',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 57, 57, 57)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ColoredBox(
                    color: const Color.fromARGB(255, 236, 166, 117),
                    child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Lottie.asset('assets/animation/ADFree.json',
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
              Container(
                height: 50.h,
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
