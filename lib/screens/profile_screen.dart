import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/user_data.dart';
import 'package:olxad/onboarding/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  bool isloading = false;
  UserDetails? currentUnserdetails;

  @override
  void initState() {
    _loaduserData();
    super.initState();
  }

  Future<void> _loaduserData() async {
    setState(() {
      isloading = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('/users')
            .doc(user.uid)
            .get();

        final data = doc.data();

        currentUnserdetails = UserDetails.fromJson(data!);

        emailController =
            TextEditingController(text: currentUnserdetails?.email ?? '');
        usernameController =
            TextEditingController(text: currentUnserdetails?.userName ?? '');
      }
    } catch (e) {
      debugPrint("Error fetching user profile: $e");

      emailController = TextEditingController(text: '');
    }
    setState(() {
      isloading = false;
    });
  }

  Future<void> _addusername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('enter username first'),
        backgroundColor: Color.fromARGB(255, 172, 98, 93),
      ));
      return;
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('/users')
            .doc(user?.uid)
            .update({'userName': usernameController.text});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username added successfully"),
            backgroundColor: Color.fromARGB(255, 83, 151, 86),
          ),
        );
      } catch (e) {
        debugPrint("Error adding username: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add username: $e"),
            backgroundColor: Color.fromARGB(255, 172, 98, 93),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/animation/user.json', height: 100),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextField(
              controller: emailController,
              readOnly: true,
              decoration: InputDecoration(),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 112, 112, 112),
                      fontSize: 14.sp)),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: (currentUnserdetails?.userName == null ||
                      currentUnserdetails!.userName!.isEmpty)
                  ? _addusername
                  : null, // disables button automatically
              child: Text('Add username'),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 255, 70, 57))),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                },
                child: Text(
                  'log out',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    ));
  }
}
