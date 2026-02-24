import 'package:flutter/material.dart';
import 'package:olxad/widgets/cards/card_details.dart';
import 'package:olxad/widgets/cards/cards.dart';
import 'package:olxad/screens/card_details_homepage.dart';

class HorizontalCars extends StatelessWidget {
  final List<CardDetails> cardDetails;
  const HorizontalCars({super.key, required this.cardDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(cardDetails.length, (index) {
          final card = cardDetails[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CardDetailsHomepage(),
                ),
              );
            },
            child: CardsCustom(
              image: Image.asset(
                'assets/images/${card.image}',
                gaplessPlayback: true,
              ),
              text: card.text,
            ),
          );
        }),
      ),
    );
  }
}
