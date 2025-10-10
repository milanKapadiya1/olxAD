import 'package:flutter/material.dart';

class AppConstans {
  AppConstans._();

  static showSnackBar(
    BuildContext context, {
    required String message,
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess
            ? const Color.fromARGB(255, 133, 212, 212)
            : const Color.fromARGB(255, 233, 63, 51),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
