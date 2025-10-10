import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
    final TextEditingController mysearchController;

  const CustomSearchBar({super.key, required this.mysearchController});

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                Icon(
                  Icons.heart_broken,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.notifications,
                  size: 24,
                  color: Colors.black,
                )
              ],
            ),
          );
  }
}