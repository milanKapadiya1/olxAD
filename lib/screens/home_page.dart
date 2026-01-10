import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

class _HomePageState extends State<HomePage> {
  String currentCity = '';
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;

  static final Map<String, List<Ad>> adcatch = {};

  List<Ad> cityAds = [];

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
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCityName(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    final cityLocation = place.locality;

    return cityLocation ?? '';
  }

  Future<void> _initLocationFlow() async {
    try {
      debugPrint("🚀🚀starting location flow");
      bool serviceEnable = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnable) {
        if (context.mounted) _showEnableLocationDialog();
        return;
      }
      Position? position = await determinPosition();
      debugPrint("📍 Coordinates: ${position!.latitude}, ${position.longitude}");

      String city = await getCityName(position);
      debugPrint("🏙️ Detected City Name: '$city'");
      if (city.isEmpty || city == 'Unknown'){
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
      // fatchcityAds("Ahmedabad");
    }
  }

  void _showEnableLocationDialog() {
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
              Navigator.pop(context);
              // Retry after a small delay to give them time to switch it on
              Future.delayed(const Duration(seconds: 1), _initLocationFlow);
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initLocationFlow();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                ],
              ),
            ),

            // THE ADS GRID (Scrolls underneath the sticky tab)
            SliverToBoxAdapter(
              child: isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ExpandedGrid(
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

// class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;

//   _StickyTabBarDelegate({required this.child, required this.height});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: AppTheme.backgroundColor,
//       child: child,
//     );
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
//     return oldDelegate.child != child;
//   }
// }
