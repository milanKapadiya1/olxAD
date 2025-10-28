import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        isSelected ? Colors.deepPurple.shade700 : Colors.white;

    final Color textColor = isSelected ? Colors.white : Colors.black87;

    final Color borderColor = isSelected
        ? Colors.deepPurple.shade700
        : const Color.fromARGB(255, 233, 233, 233);

    return InkWell(
      onTap: () => onTabSelected(myIndex),
  borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 1.5,
            color: borderColor,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Text(
          myText,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
