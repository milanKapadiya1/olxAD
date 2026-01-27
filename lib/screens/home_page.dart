import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/horizontal_cars.dart';
import 'package:olxad/widgets/recentlyview.dart';
import 'package:olxad/widgets/tabsAndad/expanded_grid.dart';
import 'package:olxad/widgets/topbar/logo_location.dart';
import 'package:olxad/widgets/topbar/search_bar.dart';
import 'package:olxad/util/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static ValueNotifier<List<Ad>> recentlyViewedNotifire = ValueNotifier([]);

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String currentCity = '';
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  bool isDialogShowing = false;

  static final Map<String, List<Ad>> adcatch = {};

  List<Ad> cityAds = [];

  final firestoredatabase = FirebaseFirestore.instance;

  //////////////////////////////// variables ends

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

//get location function, show ads based on location arrived
  Future<Position?> determinPosition() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('location service not ON');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location denied permanatly, Allow location');
    }

    Position? lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      return lastPosition;
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: const Duration(seconds: 10),
    );
  }

  Future<String> getCityName(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    final cityLocation = place.locality;
    final street = place.street;
    final subLocality = place.subLocality;
    debugPrint("Your street location is :$street ");
    debugPrint('Your street location is : $subLocality');

    return cityLocation ?? '';
  }

  Future<void> _initLocationFlow() async {
    setState(() {
      isLoading = true;
    });
    try {
      debugPrint("🚀🚀starting location flow");
      bool serviceEnable = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnable) {
        if (context.mounted) _showEnableLocationDialog();
        // setState(() {
        //   isLoading = false;
        // });
        return;
      }
      Position? position = await determinPosition();
      debugPrint(
          "📍 Coordinates: ${position!.latitude}, ${position.longitude}");

      String city = await getCityName(position);
      debugPrint("🏙️ Detected City Name: '$city'");
      if (city.isEmpty || city == 'Unknown') {
        debugPrint("city is probebly empty or unknon");
      }
      if (mounted) {
        setState(() {
          currentCity = city;
        });
        fatchcityAds(city); // Load ads for the detected city
      }
    } catch (e) {
      debugPrint("Location Error $e");
      await fatchcityAds("Mumbai"); // if loading fails show mumbai's ad
    }
  }

  void _showEnableLocationDialog() {
    setState(() {
      isDialogShowing = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false, // User must choose an option
      builder: (context) => AlertDialog(
        title: const Text("Location Needed"),
        content:
            const Text("Please turn on your location to see ads near you."),
        actions: [
          TextButton(
            onPressed: () {
              // Open phone settings
              Geolocator.openLocationSettings();
              // Navigator.pop(context);
              // // Retry after a small delay to give them time to switch it on
              // Future.delayed(const Duration(seconds: 1), _initLocationFlow);
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // User is back in the app! Check location again.
      _checkLocationOnResume();
    }
  }

  Future<void> _checkLocationOnResume() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled && isDialogShowing) {
      Navigator.of(context).pop();
      setState(() {
        isDialogShowing = false;
      });
      _initLocationFlow();
    }
  }

  ///////////////////// location functions ends...

  Future<void> _loadRecentlyVIew() async {
    final prefes = await SharedPreferences.getInstance();
    final String? savedString = prefes.getString('recent_ads');

    if (savedString != null) {
      final List<dynamic> decodedList = jsonDecode(savedString);
      final List<Ad> loadedAds =
          decodedList.map((item) => Ad.fromJson(item)).toList();
      HomePage.recentlyViewedNotifire.value = loadedAds;
    }
  }

  static Future<void> saveRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert List<Ad> to Text
    final List<Ad> currentList = HomePage.recentlyViewedNotifire.value;
    final String encodedList =
        jsonEncode(currentList.map((ad) => ad.toJson()).toList());

    // Save to disk
    await prefs.setString('recent_ads', encodedList);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initLocationFlow();
    _loadRecentlyVIew();
  }

  @override
  void dispose() {
    _searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var element in cardDetails1) {
      precacheImage(AssetImage('assets/images/${element.image}'), context);
    }
    for (var element in cardDetails2) {
      precacheImage(AssetImage('assets/images/${element.image}'), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: CustomScrollView(
          slivers: [
            //  SCROLLABLE TOP CONTENT YO THE FETURE HORIZONTAL
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  LogoLocation(cityName: currentCity),
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
                  SizedBox(height: 12.h),
                  HorizontalCars(cardDetails: cardDetails1),
                  SizedBox(height: 24.h),
                  SizedBox(height: 12.h),
                  HorizontalCars(cardDetails: cardDetails2),
                  SizedBox(height: 24.h),
                  ValueListenableBuilder(
                    valueListenable: HomePage.recentlyViewedNotifire,
                    builder: (context, value, child) {
                      if (value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(children: [
                        RecentlyViewedSection(ads: value),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Freash recommendations",
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        
                      ]);
                    },
                  )
                ],
              ),
            ),

            // THE ADS GRID (Scrolls underneath the sticky tab)
            SliverToBoxAdapter(
              child: ExpandedGrid(
                isLoading: isLoading,
                cityAds: cityAds,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
