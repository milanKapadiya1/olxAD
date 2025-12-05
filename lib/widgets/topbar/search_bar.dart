import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';

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
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: TextField(
                autocorrect: true,
                controller: mysearchController,
                decoration: InputDecoration(
                  hintText: 'Search "Jobs"',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.search,
                      size: 20.w,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: SvgPicture.asset(
              'assets/icons/Heart.svg',
              height: 24.h,
              width: 24.w,
              colorFilter:
                  const ColorFilter.mode(AppTheme.textPrimary, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 24.w,
              color: AppTheme.textPrimary,
            ),
          )
        ],
      ),
    );
  }
}
