import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Import Bloc
import 'package:olxad/bloc/homepage/home_bloc.dart';
import 'package:olxad/bloc/homepage/home_event.dart';
import 'package:olxad/screens/createad.dart';
import 'package:olxad/screens/details/liked_ads.dart';
import 'package:olxad/screens/home_page.dart';
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
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    _pages = [
      BlocProvider(
        create: (context) => HomeBloc()..add(FetchHomeData()),
        child: const HomePage(),
      ),
      const LikeScreen(),
      Createad(),
      const PurchaseScreen(),
      const ProfileScreen(),
    ];
  }

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
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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