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
import 'package:olxad/widgets/tabsAndad/expanded_grid.dart';
import 'package:olxad/widgets/tabsAndad/tab_ad_section.dart';
import 'package:olxad/widgets/topbar/logo_location.dart';
import 'package:olxad/widgets/topbar/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  bool isLoading = false;
  final List<String> locations = [
    'Ahmedabad',
    'Mumbai',
    'Delhi',
    'Chandkheda',
    'Gandhinagar',
  ];

  List<Ad> cityAds = [];
  //this will hold object of ad class, inside object we have all fields like img, title, description etc every object
  // will have this so list of object.

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
            child: TabAdSection(
                locations: locations,
                selectedIndex: selectedIndex,
                onTabSelected: _handleTabSelected),
          ),
          ExpandedGrid(isLoading: isLoading, cityAds: cityAds)
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: CustomBottomnav(),
      ),
    ));
  }
}
