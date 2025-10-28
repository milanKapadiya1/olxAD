import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoLocation extends StatelessWidget {
  const LogoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/olxLogo.png',
            height: 24.h,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 24.w,
                color: const Color.fromARGB(255, 60, 60, 60),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                'India',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 60, 60, 60)),
              ),
              SizedBox(
                width: 4.w,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 18.w,
                color: Color.fromARGB(255, 60, 60, 60),
              )
            ],
          )
        ],
      ),
    );
  }
}
