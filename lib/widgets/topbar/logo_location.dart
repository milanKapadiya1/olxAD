import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/screens/flutter_tab.dart';


class LogoLocation extends StatelessWidget {
  final String? cityName;

  const LogoLocation({super.key, this.cityName});

  final List<String> cities = const [
    'Ahmedabad',
    'Mumbai',
    'Gandhinagar',
    'Delhi',
    'Goa',
    'Leh'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/olxLogo.png',
            height: 24.h,
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (String selectedCity) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Fluttertab(initialCity: selectedCity),
                ),
              );
            },
            itemBuilder: (BuildContext context) {
              return cities.map((String city) {
                return PopupMenuItem<String>(
                  value: city,
                  child: Text(
                    city,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 60, 60, 60),
                    ),
                  ),
                );
              }).toList();
            },
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 24.w,
                  color: const Color.fromARGB(255, 60, 60, 60),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  (cityName != null && cityName!.isNotEmpty)
                      ? cityName!
                      : 'India',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 60, 60, 60)),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 18.w,
                  color: Color.fromARGB(255, 60, 60, 60),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
