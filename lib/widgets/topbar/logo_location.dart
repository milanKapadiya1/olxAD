import 'package:flutter/material.dart';

class LogoLocation extends StatelessWidget {
  const LogoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/olxLogo.png',
            height: 24,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 24,
                color: const Color.fromARGB(255, 60, 60, 60),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'India',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 60, 60, 60)),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
                color: Color.fromARGB(255, 60, 60, 60),
              )
            ],
          )
        ],
      ),
    );
  }
}
