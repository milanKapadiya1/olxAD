import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';

class CustomBottomnav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> ontimeSelected;
  const CustomBottomnav(
      {super.key, required this.currentIndex, required this.ontimeSelected});

  @override
  State<CustomBottomnav> createState() => _CustomBottomnavState();
}

class _CustomBottomnavState extends State<CustomBottomnav> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textSecondary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          onTap: widget.ontimeSelected,
          items: [
            _buildItem('assets/icons/Home.svg', 0),
            _buildItem('assets/icons/Heart.svg', 1),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            _buildItem('assets/icons/Bag.svg', 3),
            _buildItem('assets/icons/usersvg.svg', 4),
          ],
        ),
        Positioned(
          bottom: 24.h,
          child: GestureDetector(
            onTap: () {
              widget.ontimeSelected(2);
            },
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(String asset, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
        height: 24,
        width: 24,
        colorFilter:
            const ColorFilter.mode(AppTheme.textSecondary, BlendMode.srcIn),
      ),
      activeIcon: Column(
        children: [
          SvgPicture.asset(
            asset,
            height: 24,
            width: 24,
            colorFilter:
                const ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn),
          ),
          SizedBox(height: 4.h),
          Container(
            height: 5.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: AppTheme.accentColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
