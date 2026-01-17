import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/ad_model.dart';

class AdCard extends StatelessWidget {
  final Ad ad;
  final VoidCallback onTap;

  const AdCard({super.key, required this.ad, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r), // Standard border radius
          border: Border.all(
              color: Colors.grey.shade300, width: 1), // Subtle border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4.r)),
                    child: ad.image.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: ad.image,
                            height: 140.h, // Increased height for better ratio
                            width: double.infinity,
                            fit: BoxFit.cover,
                            memCacheHeight: 500,
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,

                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 140.h,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.broken_image_rounded,
                                  color: Colors.grey),
                            ),
                          )
                        : Container(
                            height: 140.h,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          )),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹ ${ad.price}", // Price first
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          ad.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black87, fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            ad.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.grey.shade600,
                                    fontSize: 10.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "", // Placeholder for date if not in model
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .bodySmall
                          //     ?.copyWith(
                          //         color: Colors.grey.shade600, fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
