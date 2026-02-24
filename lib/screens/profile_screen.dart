import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:olxad/model/user_data.dart';
import 'package:olxad/onboarding/auth/login.dart';
import 'package:olxad/screens/flutter_tab.dart';
import 'package:olxad/util/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController(); // Added
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
          phoneController = TextEditingController(
              text: currentUnserdetails?.phoneNumber ?? user.phoneNumber ?? '');
          usernameController =
              TextEditingController(text: currentUnserdetails?.userName ?? '');
        } else {
          currentUnserdetails = UserDetails(
            email: user.email,
            userName: '',
            uid: user.uid,
            phoneNumber: user.phoneNumber,
          );
          emailController = TextEditingController(text: user.email ?? '');
          phoneController = TextEditingController(text: user.phoneNumber ?? '');
          usernameController = TextEditingController(text: '');
        }
      }
    } catch (e) {
      debugPrint("Error fetching user profile: $e");

      emailController = TextEditingController(text: '');
      phoneController = TextEditingController(text: '');
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

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username added successfully"),
            backgroundColor: Color.fromARGB(255, 83, 151, 86),
          ),
        );
        _loaduserData(); // Reload to update UI
        Navigator.pop(context); // Close the bottom sheet
      } catch (e) {
        debugPrint("Error adding username: $e");

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add username: $e"),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  // Edit Profile Bottom Sheet
  void _showEditProfileBottomSheet() {
    bool isUpdating = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  MediaQuery.of(context).padding.bottom +
                  20.h,
              left: 20.w,
              right: 20.w,
              top: 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20.h),
                Text("Edit Profile",
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: 20.h),
                if (emailController.text.isNotEmpty)
                  TextField(
                    controller: emailController,
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  )
                else if (phoneController.text.isNotEmpty)
                  TextField(
                    controller: phoneController,
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_android),
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
                    onPressed: isUpdating
                        ? null
                        : () async {
                            if (usernameController.text.isNotEmpty) {
                              setModalState(() {
                                isUpdating = true;
                              });
                              await _addusername();
                              if (mounted) {
                                setModalState(() {
                                  isUpdating = false;
                                });
                              }
                            }
                          },
                    child: isUpdating
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Update Username'),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        });
      },
    );
  }

  // // two function to add more ads in firestore created with gemini.

  // Future<void> uploadAdsToCityCollections() async {
  //   // 1. Get the 30 dummy ads
  //   List<Ad> adsToUpload = getDummyAds();

  //   // ⚠️ CRITICAL STEP ⚠️
  //   // Paste the ID of the document inside 'Ads' collection here.
  //   // Example: 'Kj87sdfKJsdf876'
  //   String parentDocumentId = 'ODwaKgMlJGFfyD78DP9l';

  //   WriteBatch batch = FirebaseFirestore.instance.batch();

  //   print("Starting upload...");

  //   for (Ad ad in adsToUpload) {
  //     // 2. Construct the path
  //     // Path: Ads -> [ParentDocID] -> [CityName] -> [NewAdID]

  //     // Step A: Point to 'Ads' collection
  //     CollectionReference adsCollection =
  //         FirebaseFirestore.instance.collection('Ads');

  //     // Step B: Point to the specific parent document
  //     DocumentReference parentDocRef = adsCollection.doc(parentDocumentId);

  //     // Step C: Point to the City collection (Ahmedabad, Mumbai, or Delhi)
  //     CollectionReference cityCollection = parentDocRef.collection(ad.location);

  //     // Step D: Create a new empty document for the Ad
  //     DocumentReference newAdDoc = cityCollection.doc();

  //     // 3. Add to batch
  //     batch.set(newAdDoc, ad.toJson());
  //   }

  //   // 4. Commit the batch
  //   try {
  //     await batch.commit();
  //     print("✅ SUCCESS: 30 Ads uploaded successfully!");
  //     print("Structure: Ads -> $parentDocumentId -> CityCollections -> AdDocs");
  //   } catch (e) {
  //     print("❌ ERROR: $e");
  //   }
  // }

  // // ... (Ensure your Ad class and getAhmedabadAds function are in this file) ...

  // Future<void> uploadAhmedabadOnly() async {
  //   // 1. Get the 20 new Ahmedabad ads
  //   List<Ad> adsToUpload = getAhmedabadAds();

  //   String parentDocumentId = 'ODwaKgMlJGFfyD78DP9l';

  //   WriteBatch batch = FirebaseFirestore.instance.batch();

  //   print("Starting upload of 20 Ahmedabad Ads...");

  //   for (Ad ad in adsToUpload) {
  //     // 2. Target the Ahmedabad collection explicitly
  //     // Path: Ads -> [ParentDocID] -> Ahmedabad -> [NewAdID]

  //     DocumentReference newAdDoc = FirebaseFirestore.instance
  //         .collection('Ads')
  //         .doc(parentDocumentId)
  //         .collection('Ahmedabad') // Explicitly targeting Ahmedabad
  //         .doc();

  //     // 3. Add to batch (Uses your fixed Ad model with correct keys: Image, Title, description)
  //     batch.set(newAdDoc, ad.toJson());
  //   }

  //   // 4. Commit
  //   try {
  //     await batch.commit();
  //     print("✅ SUCCESS: 20 New Ads added to Ahmedabad collection!");
  //   } catch (e) {
  //     print("❌ ERROR: $e");
  //   }
  // }

  // function to upload ads ends //
  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Container(
                      height: 80.w,
                      width: 80.w,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(
                            255, 249, 252, 255), // OLX brand yellow
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Lottie.asset('assets/animation/user.json'),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        (currentUnserdetails?.userName != null &&
                                currentUnserdetails!.userName!.isNotEmpty)
                            ? currentUnserdetails!.userName!
                            : 'OLX User',
                        style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. "View and edit profile" Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF002F34), // Dark OLX Blue/Green
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                    ),
                    onPressed: _showEditProfileBottomSheet,
                    child: Text(
                      'View and Edit Profile',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Divider(thickness: 8, color: Colors.grey.shade100),

              // 3. Menu Items
              _buildMenuItem(
                icon: Icons.card_giftcard,
                title: "Buy Packages & My Orders",
                subtitle: "Packages, orders, billing and invoices",
                onTap: () {},
              ),
              Divider(height: 1, indent: 20.w),
              _buildMenuItem(
                icon: Icons.favorite_border,
                title: "Wishlist",
                subtitle: "View your liked items here",
                onTap: () {},
              ),

              Divider(thickness: 8, color: Colors.grey.shade100),
              // (Red circled items "Elite Buyer/Seller" removed here)

              // 4. Settings and Logout
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: "Settings",
                subtitle: "Privacy and logout",
                onTap: () {},
              ),
              Divider(height: 1, indent: 20.w),
              _buildMenuItem(
                icon: Icons.logout,
                title: "Log Out",
                subtitle: "",
                textColor: AppTheme.errorColor,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false,
                    );
                  }
                },
              ),

              SizedBox(height: 30.h),

              // 5. Browse Ads Link
              Center(
                child: TextButton(
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
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color textColor = Colors.black87,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
              ),
            )
          : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
      onTap: onTap,
    );
  }
}
