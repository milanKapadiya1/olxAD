import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/horizontal_cars.dart';
import 'package:olxad/widgets/tabsAndad/expanded_grid.dart';
import 'package:olxad/widgets/tabsAndad/tab_ad_section.dart';
import 'package:olxad/widgets/topbar/logo_location.dart';
import 'package:olxad/widgets/topbar/search_bar.dart';
import 'package:olxad/util/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
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

//  static final Map<String, List<Ad>> adcatch = {};
  final Map<String, List<Ad>> adcatch = {};

//  static int lastSelectedIndex = 0;
  List<Ad> cityAds = [];

  void _handleTabSelected(int peraindex) {
    selectedIndex.value = peraindex;
    String cityName = locations[peraindex];

    fatchcityAds(cityName);
  }

  final firestoredatabase = FirebaseFirestore.instance;

  Future<void> fatchcityAds(String cityName) async {
    if (adcatch.containsKey(cityName)) {
      setState(() {
        cityAds = adcatch[cityName]!;
        debugPrint('✅ Loaded $cityName ads from cache');
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    final cityAdssnap = await firestoredatabase
        .collection('/Ads')
        .doc('ODwaKgMlJGFfyD78DP9l')
        .collection(cityName)
        .get();

    final fetchedAds =
        cityAdssnap.docs.map((docs) => Ad.fromJson(docs.data())).toList();

    adcatch[cityName] = fetchedAds;

    setState(() {
      cityAds = fetchedAds;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // selectedIndex = ValueNotifier<int>(lastSelectedIndex);

    tabController = TabController(length: locations.length, vsync: this,);
    fatchcityAds(locations[0]);
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
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 12.h),
          const LogoLocation(),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomSearchBar(
              mysearchController: _searchController,
            ),
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey.shade200, thickness: 1),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("Featured Cars",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  SizedBox(height: 12.h),
                  HorizontalCars(cardDetails: cardDetails1),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("Fresh Recommendations",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  SizedBox(height: 12.h),
                  HorizontalCars(cardDetails: cardDetails2),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w),
                    child: TabAdSection(
                        locations: locations,
                        selectedIndex: selectedIndex,
                        onTabSelected: _handleTabSelected),
                  ),
                  ExpandedGrid(
                    isLoading: isLoading,
                    cityAds: cityAds,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
