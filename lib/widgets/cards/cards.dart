import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardsCustom extends StatelessWidget {
  final Image image;
  final String text;
  
  const CardsCustom({super.key,required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(right: 6.w, left: 18.w),
      child: Column(
        children: [
          
          Container(
            height:58.h,
            width: 58.w,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 246, 255),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: image
            ), 
          ),
          SizedBox(height: 6.h,),
          Text(text, style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 65, 65, 65),
          ),),
        ],
      ),
    );
  }
}