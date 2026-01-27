import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/screens/details/liked_ads.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController mysearchController;

  const CustomSearchBar({super.key, required this.mysearchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 0.w), // Padding handled by parent
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(4.r), // More squared corners
                border: Border.all(
                    color: Colors.black, width: 1.2), // Distinct border
              ),
              child: TextField(
                autocorrect: true,
                controller: mysearchController,
                decoration: InputDecoration(
                  hintText: 'Search "Cars"',
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                        fontSize: 16.sp,
                      ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.search,
                      size: 24.w,
                      color: Colors.black,
                    ),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LikeScreen())),
                child: Icon(
              Icons.favorite_border,
              size: 26.w,
              color: Colors.black,
            )),
            // SvgPicture.asset(
            //   'assets/icons/Heart.svg',
            //   height: 24.h,
            //   width: 24.w,
            //   colorFilter:
            //       const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            // ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 26.w,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
