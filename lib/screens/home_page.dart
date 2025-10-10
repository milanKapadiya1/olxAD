import 'package:flutter/material.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/horizontal_cars.dart';
import 'package:olxad/widgets/topbar/logo_location.dart';
import 'package:olxad/widgets/topbar/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

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
         const  SizedBox(
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
          const SizedBox(height: 12,),
          HorizontalCars(cardDetails: cardDetails2),
        ],
      ),
    ));
  }
}
