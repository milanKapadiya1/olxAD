import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olxad/manager/favorite_manager.dart';
import 'package:olxad/model/ad_model.dart';

class Ontapscreen extends StatelessWidget {
  final Ad adsDetails;
  const Ontapscreen({super.key, required this.adsDetails});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.white,
                size: 24,
              )),
          ValueListenableBuilder<List<Ad>>(
            valueListenable: FavoriteManager().favorites,
            builder: (context, value, child) {
              final isLikded = FavoriteManager().isLiked(adsDetails);
              return  IconButton(
                onPressed: () {
                  FavoriteManager().toggleFavorite(adsDetails);
                                  },
                icon: SvgPicture.asset(
                  'assets/icons/Heart.svg',
                  height: 24,
                  colorFilter: ColorFilter.mode(isLikded? const Color.fromARGB(255, 234, 67, 67) : Colors.white, BlendMode.srcIn),
                ));
            },
           
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 0.35.sh,
                width: double.infinity,
                child: Image.network(adsDetails.image, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image,
                        size: 50, color: Colors.grey),
                  );
                })),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCEE5FF),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('APPROVED DEALER',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF002F34),
                                  letterSpacing: 0.5,
                                )),
                        SizedBox(width: 6.w),
                        Image.asset(
                          'assets/images/olxLogo.png',
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    adsDetails.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF002F34),
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '₹ ${adsDetails.price}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF002F34),
                        ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 20.sp, color: Colors.grey[600]),
                      SizedBox(width: 4.w),
                      Text(
                        adsDetails.location,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ],
                  ),
                  Divider(height: 32.h, thickness: 1, color: Colors.grey[300]),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF002F34),
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    adsDetails.desc,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.chat, color: Colors.white, size: 20.sp),
                label: Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A62A3),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.call, color: Colors.white, size: 20.sp),
                label: Text(
                  'Call',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF005EB8),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    
    );
  }
}
