import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/tabbar/custom_tab.dart';

class TabAdSection extends StatelessWidget {
  final List<String> locations;
  final ValueNotifier<int> selectedIndex;
  final Function(int) onTabSelected;
  // final bool isLoading;
  // final List<Ad> cityAds;
  const TabAdSection({
    super.key,
    required this.locations,
    required this.selectedIndex,
    required this.onTabSelected,
    // required this.isLoading,
    // required this.cityAds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 24.w,
              ),
              ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(locations.length, (indexM) {
                      return CustomTab(
                        myText: locations[indexM],
                        isSelected: value == indexM,
                        myIndex: indexM,
                        onTabSelected: onTabSelected,
                      );
                    })),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
