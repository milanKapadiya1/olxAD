import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/tabsAndad/expanded_grid.dart';
import 'package:olxad/util/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fluttertab extends StatefulWidget {
  final String? initialCity;
  const Fluttertab({super.key, this.initialCity});

  @override
  State<Fluttertab> createState() => _FluttertabState();
}

class _FluttertabState extends State<Fluttertab> with TickerProviderStateMixin {
  late TabController myTabController;
  int currenttabIndex = 0;

  final List<String> cities = [
    'Ahmedabad',
    'Mumbai',
    'Gandhinagar',
    'Delhi',
    'Goa',
    'Leh'
  ];

  Map<String, List<Ad>> catchAdshere = {};

  void _handleTabSelected(int peraindex) {
    setState(() {
      currenttabIndex = peraindex;
    });

    myTabController.animateTo(peraindex);

    String cityName = cities[peraindex];
    fatchcityAds(cityName);
  }

  final firestoredatabase = FirebaseFirestore.instance;

  Future<void> fatchcityAds(String cityName) async {
    await Future.delayed(Duration.zero);
    if (catchAdshere.containsKey(cityName)) {
      return;
    }

    try {
      final cityAdssnap = await firestoredatabase
          .collection('/Ads')
          .doc('ODwaKgMlJGFfyD78DP9l')
          .collection(cityName)
          .get();

      final fetchedAds =
          cityAdssnap.docs.map((docs) => Ad.fromJson(docs.data())).toList();

      if (mounted) {
        setState(() {
          catchAdshere[cityName] = fetchedAds;
        });
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialCity != null) {
      final index = cities.indexOf(widget.initialCity!);
      if (index != -1) {
        currenttabIndex = index;
      }
    }

    myTabController = TabController(
        length: cities.length, vsync: this, initialIndex: currenttabIndex);

    myTabController.addListener(() {
      if (!myTabController.indexIsChanging &&
          myTabController.index != currenttabIndex) {
        _handleTabSelected(myTabController.index);
      }
    });

    fatchcityAds(cities[currenttabIndex]);
  }

  @override
  void dispose() {
    myTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
          title:
              Text("Browse Ads", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: Column(
          children: [
            SizedBox(height: 12.h),
            TabBar(
              tabs: List.generate(cities.length, (index) {
                bool isSelected = currenttabIndex == index;
                String text = cities[index];
                return Tab(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              labelPadding: EdgeInsets.only(left: 12.w, right: 4.w),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(), // Hide underline
              controller: myTabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              splashFactory: NoSplash.splashFactory,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: TabBarView(
                controller: myTabController,
                children: List.generate(cities.length, (index) {
                  String currentCity = cities[index];
                  List<Ad>? dataForThisCity = catchAdshere[currentCity];
                  return ExpandedGrid(
                    isLoading: dataForThisCity == null,
                    cityAds: dataForThisCity ?? [],
                    showErrorAnimation: false,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
