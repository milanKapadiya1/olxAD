import 'package:flutter/material.dart';

class CardsCustom extends StatelessWidget {
  final Image image;
  final String text;
  const CardsCustom({super.key,required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 6, left: 18),
      child: Container(
          child: Column(
            children: [
              Container(
                height:65,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 239, 246),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: image
                ), 
              ),
              SizedBox(height: 6,),
              Text(text, style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 65, 65, 65),
              ),),
            ],
          ),
      ),
    );
  }
}