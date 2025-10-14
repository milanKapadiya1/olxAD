import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/horizontal_cars.dart';
import 'package:olxad/widgets/Ads%20card/ads_card.dart';
import 'package:olxad/widgets/navigation/custom_navigation.dart';
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

  bool isLoading = false;
  final List<String> locations = [
    'Ahmedabad',
    'Mumbai',
    'Delhi',
    'Chandkheda',
    'Gandhinagar',
  ];
  List<Ad> cityAds = []; //this will hold object of ad class/

  final firestoredatabase = FirebaseFirestore.instance;

  Future<void> fatchcityAds(String cityName) async {
    setState(() {
      isLoading = true;
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 12,
            width: double.infinity,
            // child: ColoredBox(color: Color.fromARGB(255, 149, 87, 87)),
          ),
          const LogoLocation(),
          const SizedBox(
            height: 18,
          ),
          CustomSearchBar(
            mysearchController: _searchController,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 183, 183, 183)),
          ),
          const SizedBox(
            height: 24,
          ),
          HorizontalCars(cardDetails: cardDetails1),
          const SizedBox(
            height: 12,
          ),
          HorizontalCars(cardDetails: cardDetails2),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: selectedLocation == null
                      ? Column(
                          children: [
                            const Text(
                              'select location to see ads',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: locations.map((city) {
                                final bool isSelected =
                                    selectedLocation == city;
                                return ChoiceChip(
                                  label: Text(city),
                                  selected: isSelected,
                                  onSelected: (_) async {
                                    setState(() {
                                      selectedLocation = city;
                                    });
                                    await fatchcityAds(city);
                                  },
                                  selectedColor: Colors.blueAccent,
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      : isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : cityAds.isEmpty
                              ? const Text('No ads found')
                              : Column(
                                  children: [
                                    Text('Ads based on location'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      itemCount: cityAds.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 0.64,
                                      ),
                                      itemBuilder: (context, index) {
                                        return AdCard(ad: cityAds[index]);
                                      },
                                    ),
                                  ],
                                )),
            ],
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
