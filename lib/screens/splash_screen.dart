// import 'package:flutter/material.dart';
// import 'package:olxad/screens/auth_wrap.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
  
//   void initState() {
//     super.initState();
//     _goToNext();
//   }

//   Future<void> _goToNext() async {
//     await Future.delayed(const Duration(seconds: 2));

//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const AuthWrapper()),
//       );
//     }
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Image.asset(
//             'assets/images/olxLogo.png',
//             width: 120,
//           ),
//         ));
//   }
// }
