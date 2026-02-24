import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olxad/bloc/homepage/home_bloc.dart';
import 'package:olxad/bloc/homepage/home_event.dart';
import 'package:olxad/bloc/homepage/home_state.dart';
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
  final TextEditingController _searchController = TextEditingController();

  // NOTE: All logic variables (isLoading, currentCity, cityAds, firestore) are DELETED.
  // The Bloc handles them now.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadRecentlyVIew();
  }

  @override
  void dispose() {
    _searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // If user enabled location in settings and came back, try fetching again
      context.read<HomeBloc>().add(FetchHomeData());
    }
  }

  void _showEnableLocationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Location Needed"),
        content:
            const Text("Please turn on your location to see ads near you."),
        actions: [
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(context);
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> _loadRecentlyVIew() async {
    final prefes = await SharedPreferences.getInstance();
    final String? savedString = prefes.getString('recent_ads');
    if (savedString != null) {
      final List<dynamic> decodedList = jsonDecode(savedString);
      final List<Ad> loadedAds =
          decodedList.map((item) => Ad.fromJson(item)).toList();

      // Check if the list content is different to avoid flickering (unnecessary rebuilds)
      if (!listEquals(HomePage.recentlyViewedNotifire.value, loadedAds)) {
        HomePage.recentlyViewedNotifire.value = loadedAds;
      }
    }
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
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLocationDisabled) {
              _showEnableLocationDialog();
            } else if (state is HomeError) {
              // Optional: Show a snackbar if error occurs
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            // Default Values
            String displayCity = "";
            List<Ad> displayAds = [];
            bool isLoading = false;

            // Update UI based on State
            if (state is HomeLoading) {
              isLoading = true;
              displayCity = "Locating...";
            } else if (state is HomeLoaded) {
              displayCity = state.city;
              displayAds = state.ads;
            } else if (state is HomeError) {
              displayCity = "Mumbai";
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      LogoLocation(cityName: displayCity),
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

                      // Recently Viewed (Kept local as requested)
                      ValueListenableBuilder(
                        valueListenable: HomePage.recentlyViewedNotifire,
                        builder: (context, value, child) {
                          if (value.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Column(children: [
                            RecentlyViewedSection(ads: value),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Fresh recommendations",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ]);
                        },
                      )
                    ],
                  ),
                ),

                // 2. Pass Ads & Loading State from Bloc
                SliverToBoxAdapter(
                  child: ExpandedGrid(
                    isLoading: isLoading,
                    cityAds: displayAds,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
