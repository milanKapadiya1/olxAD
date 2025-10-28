import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController mysearchController;

  const CustomSearchBar({super.key, required this.mysearchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                // color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                autocorrect: true,
                controller: mysearchController,
                decoration: InputDecoration(
                  hintText: 'Search "Jobs"',
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 50, 50, 50),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.search,
                      size: 20.w,
                      color: const Color.fromARGB(255, 62, 62, 62),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(strokeAlign: 12),
                  ),
                  // contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          SvgPicture.asset(
            'assets/icons/Heart.svg',
            height: 20.h,
            width: 20.w,
            color: const Color.fromARGB(255, 60, 60, 60),
            // placeholderBuilder: (context) => const SizedBox(
            //   height: 24,
            //   width: 24,
            //   child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            // ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Icon(
            Icons.notifications_none_outlined,
            size: 24.w,
            color: Color.fromARGB(255, 60, 60, 60),
          )
        ],
      ),
    );
  }
}
