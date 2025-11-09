import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Createad extends StatefulWidget {
  const Createad({
    super.key,
  });

  @override
  State<Createad> createState() => _CreateadState();
}

class _CreateadState extends State<Createad> {
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final userEmail = FirebaseAuth.instance.currentUser?.email;

  bool isLoading = false;

  InputDecoration _underlineDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: const Color.fromARGB(255, 130, 130, 130),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 58, 58, 58)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF3B82F6), width: 1.5),
      ),
    );
  }

  Future<void> addAdsinfirestore() async {
    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        priceController.text.isEmpty ||
        locationController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final firestore = FirebaseFirestore.instance;
      final location = locationController.text.trim();
      await firestore
          .collection('/Ads')
          .doc('ODwaKgMlJGFfyD78DP9l')
          .collection(location)
          .add({
        "Image": imageUrlController.text,
        "Title": titleController.text.trim(),
        "description": descController.text.trim(),
        "location": locationController.text.trim(),
        "price": priceController.text.trim(),
        "userEmail": userEmail,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ad uploaded successfully!')),
      );
    } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload ad: $e')),
    );

    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Create ad for : $userEmail',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 57, 57, 57)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ColoredBox(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            'assets/gif/adgif.gif',
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 50.h,
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: _underlineDecoration('Put image url'),
                ),
                SizedBox(
                  height: 28.h,
                ),
                TextField(
                  controller: titleController,
                  decoration: _underlineDecoration('Enter title of ad'),
                ),
                SizedBox(
                  height: 28.h,
                ),
                TextField(
                  controller: descController,
                  decoration: _underlineDecoration('Enter short description'),
                ),
                SizedBox(
                  height: 28.h,
                ),
                TextField(
                  controller: priceController,
                  decoration: _underlineDecoration('Price'),
                ),
                SizedBox(
                  height: 28.h,
                ),
                TextField(
                  controller: locationController,
                  decoration: _underlineDecoration(
                      'Location Ex: Ahmedabad (start with capital latter)'),
                ),
                SizedBox(
                  height: 24.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      isLoading ? null : addAdsinfirestore();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: isLoading?
                    const CircularProgressIndicator(color: Colors.white,)
                    : const
                     Text(
                      "Create Ad",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
