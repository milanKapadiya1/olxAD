import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olxad/manager/favorite_manager.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/screens/details/ontapscreen.dart';

class Likeuitile extends StatelessWidget {
  final Ad ads;
  const Likeuitile({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ontapscreen(adsDetails: ads)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: ads.image,
                height: 80.h,
                width: 80.w,
                fit: BoxFit.cover,
                memCacheHeight: 200,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade300,
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline_outlined),
              ),
            ),
            SizedBox(width: 12.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ads.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "₹ ${ads.price}",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    ads.location,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Remove from favorites directly
                FavoriteManager().toggleFavorite(ads);
              },
              icon:  SvgPicture.asset('assets/icons/Heart.svg', colorFilter: ColorFilter.mode( Colors.red, BlendMode.srcIn))
            )
          ],
        ),
      ),
    );
  }
}
