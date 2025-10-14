import 'package:flutter/material.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: const Center(
          child: Text("You don't have any liked item"),
          
        ),
      ),
    );
  }
}