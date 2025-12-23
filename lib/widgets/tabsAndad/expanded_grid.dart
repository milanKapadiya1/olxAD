import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/screens/details/ontapscreen.dart';
import 'package:olxad/widgets/Ads%20card/ads_card.dart';

class ExpandedGrid extends StatefulWidget {
  final bool isLoading;
  final List<Ad> cityAds;
  final bool showErrorAnimation;
  const ExpandedGrid(
      {super.key,
      required this.isLoading,
      required this.cityAds,
      this.showErrorAnimation = true});

  @override
  State<ExpandedGrid> createState() => _ExpandedGridState();
}

class _ExpandedGridState extends State<ExpandedGrid> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? SizedBox(
            height: 200.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : widget.cityAds.isEmpty
            ? widget.showErrorAnimation
                ? Center(
                    child: Lottie.asset('assets/animation/error.json',
                        height: 300))
                : const SizedBox()
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                addAutomaticKeepAlives: true,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.h,
                  crossAxisSpacing: 4.w,
                  childAspectRatio: 0.65.h, //  Adjust height/width ratio
                ),
                itemCount: widget.cityAds.length,
                itemBuilder: (context, index) {
                  final ad = widget.cityAds[index];
                  return AdCard(
                      ad: ad,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Ontapscreen(adsDetails: ad)));
                      });
                },
              );
  }
}

// class expandedGrid2 extends StatefulWidget {
//   final bool isLoading;
//   final List<Ad> cityAds;
//   const expandedGrid2(
//       {super.key, required this.cityAds, required this.isLoading});

//   @override
//   State<expandedGrid2> createState() => _expandedGrid2State();
// }

// class _expandedGrid2State extends State<expandedGrid2> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: widget.isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : widget.cityAds.isEmpty
//               // ? Center(
//               //     child: Lottie.asset('assets/animation/error.json',
//               //         height: 300))
//               ? Center(
//                   child: Text(''),
//                 )
//               : GridView.builder(
//                   addAutomaticKeepAlives: true,
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12.h,
//                     crossAxisSpacing: 12.w,
//                     childAspectRatio: 0.60.h, //  Adjust height/width ratio
//                   ),
//                   itemCount: widget.cityAds.length,
//                   itemBuilder: (context, index) {
//                     final ad = widget.cityAds[index];
//                     return AdCard(ad: ad);
//                   },
//                 ),
//     );
//     ;
//   }
// }
