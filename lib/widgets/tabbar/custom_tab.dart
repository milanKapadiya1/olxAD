import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';

class CustomTab extends StatelessWidget {
  final String myText;
  final bool isSelected;
  final int myIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTab({
    super.key,
    required this.myText,
    required this.isSelected,
    required this.myIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isSelected ? AppTheme.primaryColor : Colors.white;

    final Color textColor = isSelected ? Colors.white : AppTheme.textPrimary;

    final Color borderColor =
        isSelected ? AppTheme.primaryColor : Colors.grey.shade300;

    return InkWell(
      onTap: () => onTabSelected(myIndex),
      borderRadius: BorderRadius.circular(8.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 1.5,
            color: borderColor,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Text(
          myText,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
