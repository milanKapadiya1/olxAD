// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType keyboardType;
//   final bool readOnly;
//   final int maxLines;

//   const MyTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.keyboardType = TextInputType.text,
//     this.readOnly = false,
//     this.maxLines = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       readOnly: readOnly,
//       maxLines: maxLines,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(
//           fontSize: 14.sp,
//           color: const Color.fromARGB(255, 130, 130, 130),
//         ),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Color(0xFF3B82F6), width: 1.5),
//         ),
//       ),
//     );
//   }
// }
