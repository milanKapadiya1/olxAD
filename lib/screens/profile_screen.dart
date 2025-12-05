import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/user_data.dart';
import 'package:olxad/onboarding/auth/login.dart';
import 'package:olxad/screens/flutterTab.dart';
import 'package:olxad/util/app_theme.dart';

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

        if (data != null) {
          currentUnserdetails = UserDetails.fromJson(data);
          emailController =
              TextEditingController(text: currentUnserdetails?.email ?? '');
          usernameController =
              TextEditingController(text: currentUnserdetails?.userName ?? '');
        } else {
          currentUnserdetails =
              UserDetails(email: user.email, userName: '', uid: user.uid);
          emailController = TextEditingController(text: user.email ?? '');
          usernameController = TextEditingController(text: '');
        }
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
        backgroundColor: AppTheme.errorColor,
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
            backgroundColor: AppTheme.errorColor,
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
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child:
                    Lottie.asset('assets/animation/user.json', height: 100.h),
              ),
            ),
            SizedBox(height: 32.h),
            TextField(
              controller: emailController,
              readOnly: true,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: usernameController,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (currentUnserdetails?.userName == null ||
                        currentUnserdetails!.userName!.isEmpty)
                    ? _addusername
                    : null, // disables button automatically
                child: const Text('Update Username'),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text('Log Out')),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Fluttertab()));
                },
                child: Text(
                  'Browse Ads',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    ));
  }
}
