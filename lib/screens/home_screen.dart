import 'package:flutter/material.dart';
import 'package:olxad/screens/createad.dart';
import 'package:olxad/screens/home_page.dart';
import 'package:olxad/screens/like_screen.dart';
import 'package:olxad/screens/profile_screen.dart';
import 'package:olxad/screens/purchase_screen.dart';
import 'package:olxad/widgets/bottom_nav/custom_navigation.dart';
import 'package:olxad/util/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// //  final  emailController = TextEditingController();
//     final email = FirebaseAuth.instance.currentUser?.email;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const LikeScreen(),
    Createad(),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: IndexedStack(index: _selectedIndex, children: _pages, ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SizedBox(
            height: 70,
            child: CustomBottomnav(
              currentIndex: _selectedIndex,
              ontimeSelected: _onItemSelected,
            ),
          ),
        ),
      ),
    );
  }
}
