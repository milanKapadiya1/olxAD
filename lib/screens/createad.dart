import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';

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

  Future<void> addAdsinfirestore() async {
    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        priceController.text.isEmpty ||
        locationController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all fields',
          ),
          backgroundColor: AppTheme.errorColor,
        ),
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
        "price": int.tryParse(priceController.text.trim()),
        "userEmail": userEmail,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Ad uploaded successfully!'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to upload ad: $e'),
              backgroundColor: AppTheme.errorColor),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title:
              Text("Create Ad", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
          backgroundColor: AppTheme.backgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person,
                            color: AppTheme.primaryColor, size: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Posting as',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              userEmail ?? 'Guest',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    prefixIcon: Icon(Icons.image_outlined),
                    hintText: 'https://example.com/image.jpg',
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.title),
                    hintText: 'e.g. iPhone 14 Pro Max',
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description_outlined),
                    hintText: 'Describe your item...',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.attach_money),
                    hintText: '0.00',
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    hintText: 'e.g. Ahmedabad',
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      isLoading ? null : addAdsinfirestore();
                    },
                    child: isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Post Ad"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
