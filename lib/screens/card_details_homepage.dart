import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/model/dummy_category_ads.dart';
import 'package:olxad/widgets/Ads card/ads_card.dart';

class CardDetailsHomepage extends StatefulWidget {
  const CardDetailsHomepage({super.key});

  @override
  State<CardDetailsHomepage> createState() => _CardDetailsHomepageState();
}

class _CardDetailsHomepageState extends State<CardDetailsHomepage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> categories = [
    {'name': 'Cars', 'icon': 'assets/images/car.png'},
    {'name': 'Bikes', 'icon': 'assets/images/bike.png'},
    {'name': 'Properties', 'icon': 'assets/images/house.png'},
    {'name': 'Electronics & Appliances', 'icon': 'assets/images/mobile.png'},
    {'name': 'Mobiles', 'icon': 'assets/images/mobile.png'},
    {'name': 'Commercial Vehicles & Spares', 'icon': 'assets/images/car.png'},
    {'name': 'Jobs', 'icon': 'assets/images/job.png'},
    {'name': 'Furniture', 'icon': 'assets/images/furniture.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: AppTheme.textPrimary, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Categories",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side - Categories Column
          Container(
            width: 100.w,
            color: Colors.grey.shade100,
            child: ListView.builder(
              itemCount: categories.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.surfaceColor
                          : Colors.transparent,
                      border: isSelected
                          ? Border(
                              left: BorderSide(
                                color: AppTheme.accentColor,
                                width: 4.w,
                              ),
                            )
                          : null,
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? AppTheme.accentColor.withValues(alpha: 0.1)
                                : Colors.transparent,
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Image.asset(
                            categories[index]['icon']!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.category,
                                size: 24.sp,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          categories[index]['name']!,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? AppTheme.primaryColor
                                        : AppTheme.textSecondary,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Side - Ads Grid
          Expanded(
            child: Container(
              color: AppTheme.surfaceColor,
              child: Builder(
                builder: (context) {
                  final String currentCategory =
                      categories[_selectedIndex]['name']!;
                  final List<Ad> categoryAds =
                      getCategoryDummyAds(currentCategory);

                  if (categoryAds.isEmpty) {
                    return Center(
                      child: Text(
                        "No ads found for $currentCategory",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.all(8.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 0.52,
                    ),
                    itemCount: categoryAds.length,
                    itemBuilder: (context, index) {
                      return AdCard(
                        ad: categoryAds[index],
                        onTap: () {
                          // Handle ad tap if needed
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
