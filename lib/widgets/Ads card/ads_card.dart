import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/ad_model.dart';

class AdCard extends StatelessWidget {
  final Ad ad;

  const AdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 241, 246, 247),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              ad.image,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Color.fromARGB(255, 49, 49, 49)),
                ),
                SizedBox(height: 4.h),
                Text(
                  ad.desc,
                  style: TextStyle(
                      fontSize: 14.sp, color: Color.fromARGB(255, 49, 49, 49)),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Text(
                      'Price : ',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 54, 54, 54), fontWeight: FontWeight.w600),
                    ),
                    Text(ad.price.toString(),
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.black ),
                    Text(ad.location,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Color.fromARGB(255, 49, 49, 49))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
