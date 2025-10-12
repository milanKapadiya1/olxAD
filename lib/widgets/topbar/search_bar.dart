import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController mysearchController;

  const CustomSearchBar({super.key, required this.mysearchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                // color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                autocorrect: true,
                controller: mysearchController,
                decoration: InputDecoration(
                  hintText: 'Search "Jobs"',
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 50, 50, 50),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: const Color.fromARGB(255, 62, 62, 62),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(strokeAlign: 12),
                  ),
                  // contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          SvgPicture.asset(
            'assets/icons/Heart.svg',
            height: 22,
            width: 22,
            color: const Color.fromARGB(255, 60, 60, 60),
            // placeholderBuilder: (context) => const SizedBox(
            //   height: 24,
            //   width: 24,
            //   child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            // ),
          ),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.notifications,
            size: 24,
            color: Color.fromARGB(255, 60, 60, 60),
          )
        ],
      ),
    );
  }
}
