import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/Ads%20card/ads_card.dart';

class ExpandedGrid extends StatefulWidget {
  final bool isLoading;
  final List<Ad> cityAds;

  const ExpandedGrid({super.key, required this.isLoading, required this.cityAds});

  @override
  State<ExpandedGrid> createState() => _ExpandedGridState();
}

class _ExpandedGridState extends State<ExpandedGrid> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
            child: widget.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                    )
                : widget.cityAds.isEmpty
                    ? Center(
                        child: Lottie.asset('assets/animation/error.json',
                            height: 300))
                    : GridView.builder(
                      addAutomaticKeepAlives: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio:
                              0.60.h, //  Adjust height/width ratio
                        ),
                        itemCount: widget.cityAds.length,
                        itemBuilder: (context, index) {
                          final ad = widget.cityAds[index];
                          return AdCard(ad: ad);
                        },
                      ),
          );
  }
}