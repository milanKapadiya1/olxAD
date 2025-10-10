import 'package:flutter/material.dart';
import 'package:olxad/widgets/card_details.dart';
import 'package:olxad/widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 12,
            width: double.infinity,
            // child: ColoredBox(color: Color.fromARGB(255, 149, 87, 87)),
          ),
          Padding(
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
                      color: const Color.fromARGB(255, 36, 36, 36),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'India',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      // color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      autocorrect: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search "Jobs"',
                        hintStyle: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.search,
                            size: 20,
                            color: const Color.fromARGB(255, 62, 62, 62),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(strokeAlign: 12),
                        ),
                        // contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.heart_broken,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.notifications,
                  size: 24,
                  color: Colors.black,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 183, 183, 183)),
          ),
          SizedBox(
            height: 24,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(cardDetails.length, (index) {
                final card = cardDetails[index];
                return CardsCustom(
                  image: Image.asset(
                    'assets/images/${card.image}',
                    fit: BoxFit.contain,
                  ),
                  text: card.text,
                );
              }),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(cardDetails.length, (index) {
                final card = cardDetails[index];
                return CardsCustom(
                  image: Image.asset(
                    'assets/images/${card.image}',
                    fit: BoxFit.contain,
                  ),
                  text: card.text,
                );
              }),
            ),
          ),
        ],
      ),
    ));
  }
}
