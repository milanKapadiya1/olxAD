import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomnav extends StatefulWidget {
  const CustomBottomnav({super.key});

  @override
  State<CustomBottomnav> createState() => _CustomBottomnavState();
}

class _CustomBottomnavState extends State<CustomBottomnav> {
  int _currentNavIndex = 0;

  void _ontiemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  static const Color _selectedColor = Color.fromARGB(255, 88, 151, 223);
  static const Color unselectedColor = Color(0xFFA2A2A2);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: _selectedColor,
        unselectedItemColor: unselectedColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentNavIndex,
        onTap: _ontiemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Home.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            activeIcon: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Home.svg',
                  height: 24,
                  width: 24,
                  colorFilter:
                      const ColorFilter.mode(_selectedColor, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 5,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 28, 238),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Heart.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            activeIcon: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Heart.svg',
                  height: 24,
                  width: 24,
                  colorFilter:
                      const ColorFilter.mode(_selectedColor, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 5,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 28, 238),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            label: 'Heart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Bag.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            activeIcon: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Bag.svg',
                  height: 24,
                  width: 24,
                  colorFilter:
                      const ColorFilter.mode(_selectedColor, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 5,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 28, 238),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Notification.svg',
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
              ),
              activeIcon: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/Notification.svg',
                    height: 24,
                    width: 24,
                    colorFilter:
                        const ColorFilter.mode(_selectedColor, BlendMode.srcIn),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 5,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 74, 28, 238),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ],
              ),
              label: 'Notification')
        ]);
  }
}
