import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/Ads%20card/ads_card.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/horizontal_cars.dart';
import 'package:olxad/widgets/bottom_nav/custom_navigation.dart';
import 'package:olxad/widgets/tabbar/custom_tab.dart';
import 'package:olxad/widgets/topbar/logo_location.dart';
import 'package:olxad/widgets/topbar/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedLocation;
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final PageController pageController = PageController();
  bool isLoading = false;
  final List<String> locations = [
    'Ahmedabad',
    'Mumbai',
    'Delhi',
    'Chandkheda',
    'Gandhinagar',
  ];
  // final List<Widget> contentWidgets = const [
  //   Center(
  //       child:
  //           Text('Content for Ahmedabad Ads', style: TextStyle(fontSize: 20))),
  //   Center(
  //       child: Text('Content for Mumbai Ads', style: TextStyle(fontSize: 20))),
  //   Center(
  //       child: Text('Content for Delhi Ads', style: TextStyle(fontSize: 20))),
  //   Center(
  //       child:
  //           Text('Content for Chandkheda Ads', style: TextStyle(fontSize: 20))),
  //   Center(
  //       child: Text('Content for Gandhinagar Ads',
  //           style: TextStyle(fontSize: 20))),
  // ];
  List<Ad> cityAds = []; //this will hold object of ad class/

  void _handleTabSelected(int peraindex) {
    selectedIndex.value = peraindex;
    String cityName = locations[peraindex];

    fatchcityAds(cityName);
  }

  final firestoredatabase = FirebaseFirestore.instance;

  Future<void> fatchcityAds(String cityName) async {
    setState(() {
      isLoading = true;
      cityAds.clear();
    });
    final cityAdssnap = await firestoredatabase
        .collection('/Ads')
        .doc('ODwaKgMlJGFfyD78DP9l')
        .collection(cityName)
        .get();
    cityAdssnap.docs
        .map((docs) => cityAds.add(Ad.fromJson(docs.data())))
        .toList();

    setState(() {
      isLoading = false;
    });
  }
  @override
void initState() {
  super.initState();
  fatchcityAds(locations[selectedIndex.value]);
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
            width: double.infinity,
            // child: ColoredBox(color: Color.fromARGB(255, 149, 87, 87)),
          ),
          const LogoLocation(),
          SizedBox(
            height: 18.h,
          ),
          CustomSearchBar(
            mysearchController: _searchController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            height: 1,
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 183, 183, 183)),
          ),
          SizedBox(
            height: 24.h,
          ),
          HorizontalCars(cardDetails: cardDetails1),
          SizedBox(
            height: 12.h,
          ),
          HorizontalCars(cardDetails: cardDetails2),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.w),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: selectedIndex,
                        builder: (context, value, child) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children:
                                    List.generate(locations.length, (indexM) {
                              return CustomTab(
                                myText: locations[indexM],
                                isSelected: value == indexM,
                                myIndex: indexM,
                                onTabSelected: _handleTabSelected,
                              );
                            })),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : cityAds.isEmpty
                    ?  Center(child: Lottie.asset('assets/animation/error.json',height: 300))
                    : GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          mainAxisSpacing: 12.h, 
                          crossAxisSpacing: 12.w, 
                          childAspectRatio:
                              0.60.h, //  Adjust height/width ratio
                        ),
                        itemCount: cityAds.length,
                        itemBuilder: (context, index) {
                          final ad = cityAds[index];
                          return AdCard(ad: ad);
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: CustomBottomnav(),
      ),
    ));
  }
}
