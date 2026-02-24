import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/util/app_theme.dart';
import 'package:olxad/widgets/Ads%20card/ads_card.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/manager/purchase_manager.dart';
import 'package:olxad/screens/details/ontapscreen.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "My Purchases",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Color(0xFF002F34),
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<Ad>>(
        valueListenable: PurchaseManager().purchases,
        builder: (context, purchasedItems, child) {
          return purchasedItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          size: 64,
                          color: AppTheme.textSecondary.withValues(alpha: 0.5)),
                      const SizedBox(height: 16),
                      Text(
                        "No purchases yet",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GridView.builder(
                    itemCount: purchasedItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.72.h,
                    ),
                    itemBuilder: (context, index) {
                      final ad = purchasedItems[index];

                      return AdCard(
                        ad: ad,
                        isPurchased: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Ontapscreen(adsDetails: ad),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
