import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/tabsAndad/expanded_grid.dart';

class Fluttertab extends StatefulWidget {
  const Fluttertab({super.key});

  @override
  State<Fluttertab> createState() => _FluttertabState();
}

class _FluttertabState extends State<Fluttertab> with TickerProviderStateMixin {
  late TabController myTabController;
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final Color selectedColor = const Color.fromARGB(255, 77, 110, 200);
  final List<String> cities = [
    'Ahmedabad',
    'Mumbai',
    'Gandhinagar',
    'Delhi',
    'Goa',
    'Leh'
  ];

  List<Ad> cityAds = [];
  bool isLoading = false;

  void _handleTabSelected(int peraindex) {
    myTabController.animateTo(peraindex);
    selectedIndex.value = peraindex;
    String cityName = cities[peraindex];

    fatchcityAds(cityName);
  }

  final firestoredatabase = FirebaseFirestore.instance;

  Future<void> fatchcityAds(String cityName) async {
    // // ✅ Step 1: Check cache first
    // if (adcatch.containsKey(cityName)) {
    //   setState(() {
    //     cityAds = adcatch[cityName]!;
    //     debugPrint('✅ Loaded $cityName ads from cache');
    //   });
    //   return;
    // }

    // ✅ Step 2: Show loader (don't clear current list)

    setState(() {
      // cityAds.clear() ;
      isLoading = true;
    });

    // ✅ Step 3: Fetch from Firestore
    final cityAdssnap = await firestoredatabase
        .collection('/Ads')
        .doc('ODwaKgMlJGFfyD78DP9l')
        .collection(cityName)
        .get();

    final fetchedAds =
        cityAdssnap.docs.map((docs) => Ad.fromJson(docs.data())).toList();

    // // ✅ Step 4: Cache it
    // adcatch[cityName] = fetchedAds;

    // ✅ Step 5: Update UI
    setState(() {
      cityAds = fetchedAds;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    myTabController = TabController(length: cities.length, vsync: this);

    // link tab controller changes to the valuenotifies
    myTabController.addListener(() {
      if (myTabController.index != selectedIndex.value) {
        _handleTabSelected(myTabController.index);
        // selectedIndex.value = myTabController.index;
      }
    });
    fatchcityAds(cities[selectedIndex.value]);
  }

  @override
  void dispose() {
    myTabController.dispose();
    selectedIndex.dispose();
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
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) {
                return TabBar(
                  tabs: List.generate(cities.length, (index) {
                    bool isSelected = value == index;
                    String text = cities[index];
                    return Tab(
                      child: GestureDetector(
                        onTap: () {

                          _handleTabSelected(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? selectedColor : Colors.transparent,
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors.grey.shade400, width: 1.5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  labelPadding: EdgeInsets.only(left: 12),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      // color: const Color.fromARGB(255, 77, 110, 200),
                      // borderRadius: BorderRadius.circular(50),
                      ),
                  controller: myTabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  splashFactory: NoSplash.splashFactory,
                );
              },
            ),
            Expanded(
              child: TabBarView(
                controller: myTabController,
                children: List.generate(cities.length, (index) {
                  // Every tab view shows the same ExpandedGrid.
                  // The data displayed by the grid (cityAds) is controlled
                  // by the 'setState' call inside fatchCityAds.
                  return ExpandedGrid(
                    isLoading: isLoading,
                    cityAds: cityAds,
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
