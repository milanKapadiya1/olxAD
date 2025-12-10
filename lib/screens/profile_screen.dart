import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/ad_model.dart';
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


// two function to add more ads in firestore created with gemini.

Future<void> uploadAdsToCityCollections() async {
  // 1. Get the 30 dummy ads
  List<Ad> adsToUpload = getDummyAds();

  // ⚠️ CRITICAL STEP ⚠️
  // Paste the ID of the document inside 'Ads' collection here.
  // Example: 'Kj87sdfKJsdf876'
  String parentDocumentId = 'ODwaKgMlJGFfyD78DP9l'; 

 

  WriteBatch batch = FirebaseFirestore.instance.batch();

  print("Starting upload...");

  for (Ad ad in adsToUpload) {
    // 2. Construct the path
    // Path: Ads -> [ParentDocID] -> [CityName] -> [NewAdID]
    
    // Step A: Point to 'Ads' collection
    CollectionReference adsCollection = FirebaseFirestore.instance.collection('Ads');
    
    // Step B: Point to the specific parent document
    DocumentReference parentDocRef = adsCollection.doc(parentDocumentId);

    // Step C: Point to the City collection (Ahmedabad, Mumbai, or Delhi)
    CollectionReference cityCollection = parentDocRef.collection(ad.location);

    // Step D: Create a new empty document for the Ad
    DocumentReference newAdDoc = cityCollection.doc();

    // 3. Add to batch
    batch.set(newAdDoc, ad.toJson());
  }

  // 4. Commit the batch
  try {
    await batch.commit();
    print("✅ SUCCESS: 30 Ads uploaded successfully!");
    print("Structure: Ads -> $parentDocumentId -> CityCollections -> AdDocs");
  } catch (e) {
    print("❌ ERROR: $e");
  }
}


// ... (Ensure your Ad class and getAhmedabadAds function are in this file) ...

Future<void> uploadAhmedabadOnly() async {
  // 1. Get the 20 new Ahmedabad ads
  List<Ad> adsToUpload = getAhmedabadAds();

  String parentDocumentId = 'ODwaKgMlJGFfyD78DP9l'; 

  

  WriteBatch batch = FirebaseFirestore.instance.batch();

  print("Starting upload of 20 Ahmedabad Ads...");

  for (Ad ad in adsToUpload) {
    // 2. Target the Ahmedabad collection explicitly
    // Path: Ads -> [ParentDocID] -> Ahmedabad -> [NewAdID]
    
    DocumentReference newAdDoc = FirebaseFirestore.instance
        .collection('Ads')
        .doc(parentDocumentId)
        .collection('Ahmedabad') // Explicitly targeting Ahmedabad
        .doc(); 

    // 3. Add to batch (Uses your fixed Ad model with correct keys: Image, Title, description)
    batch.set(newAdDoc, ad.toJson());
  }

  // 4. Commit
  try {
    await batch.commit();
    print("✅ SUCCESS: 20 New Ads added to Ahmedabad collection!");
  } catch (e) {
    print("❌ ERROR: $e");
  }
}
// function to upload ads ends //
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
                padding: EdgeInsets.all(16.r),
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
                child: Lottie.asset('assets/animation/user.json', height: 80.h),
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
            // SizedBox(height: 4.h),
             TextButton(
                onPressed: () async {
                 await uploadAdsToCityCollections();
                 ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload Complete! Check Firebase Console.')),
        );
                },
                child: Text(
                  'Upload Ads(from list)',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            TextButton(
                onPressed: () async {
                 await uploadAhmedabadOnly();
                 ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload Complete! Check Firebase Console.')),
        );
                },
                child: Text(
                  'Upload Ahmedabad ads',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
