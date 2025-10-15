import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomnav extends StatefulWidget {
  const CustomBottomnav({super.key});

  @override
  State<CustomBottomnav> createState() => _CustomBottomnavState();
}

class _CustomBottomnavState extends State<CustomBottomnav> {
  int _currentNavIndex = 0;

  static const Color _selectedColor = Color.fromARGB(255, 88, 151, 223);
  static const Color unselectedColor = Color(0xFFA2A2A2);

  static const List<Color> _gradientColors = [
    Color(0xFF34C759), 
    Color(0xFF007AFF), 
    Color(0xFFFFCC00),
    Color(0xFF34C759), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: _selectedColor,
          unselectedItemColor: unselectedColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentNavIndex,
          onTap: _onItemTapped,
          items: [
            _buildItem('assets/icons/Home.svg', 0),
            _buildItem('assets/icons/Heart.svg', 1),
            // Placeholder for the center FAB
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            _buildItem('assets/icons/Bag.svg', 3),
            _buildItem('assets/icons/Notification.svg', 4),
          ],
        ),
        Positioned(
          bottom: 24,
          child: GestureDetector(
            onTap: () {
              print("Center button tapped");
            },
            child: Container(
              height: 60, 
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: _gradientColors,
                  startAngle: 1.5708, // Start at the top (90 degrees or pi/2 radians)
                  endAngle: 7.85398, // Sweep 2*pi
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5), 
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  height:50, 
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.add,
                    color: _selectedColor, 
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(String asset, int index) {
    final isSelected = _currentNavIndex == index;

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
        height: 24,
        width: 24,
        colorFilter: const ColorFilter.mode(unselectedColor, BlendMode.srcIn),
      ),
      activeIcon: Column(
        children: [
          SvgPicture.asset(
            asset,
            height: 24,
            width: 24,
            colorFilter:
                const ColorFilter.mode(_selectedColor, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Container(
            height: 5,
            width: 10,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 74, 28, 238),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
