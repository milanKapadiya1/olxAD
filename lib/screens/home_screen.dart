import 'package:flutter/material.dart';
import 'package:olxad/screens/createad.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/screens/like_screen.dart';
import 'package:olxad/screens/profile_screen.dart';
import 'package:olxad/screens/purchase_screen.dart';
import 'package:olxad/widgets/bottom_nav/custom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
   const HomePage(),
   const LikeScreen(),
   const Createad(),
   const PurchaseScreen(),
   const ProfileScreen(),
  ];
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      body: _pages[_selectedIndex],
       bottomNavigationBar: SizedBox(
        height: 70,
        child: CustomBottomnav(
          currentIndex:_selectedIndex ,
          ontimeSelected:_onItemSelected ,
        ),
      ),
    ),
    );
  }
}