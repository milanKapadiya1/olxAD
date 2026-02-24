import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:olxad/model/ad_model.dart';

class PurchaseManager {
  static final PurchaseManager _instance = PurchaseManager._internal();
  factory PurchaseManager() => _instance;
  PurchaseManager._internal();

  final ValueNotifier<List<Ad>> purchases = ValueNotifier<List<Ad>>([]);
  bool _initialized = false;

  // Initialize method to load saved purchases
  Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedString = prefs.getString('purchased_ads');

      if (savedString != null) {
        final List<dynamic> decodedList = jsonDecode(savedString);
        final List<Ad> loadedAds =
            decodedList.map((item) => Ad.fromJson(item)).toList();

        purchases.value = loadedAds;
      }
      _initialized = true;
    } catch (e) {
      debugPrint("Error loading purchases: $e");
    }
  }

  // Add an ad to purchases
  Future<void> addPurchase(Ad ad) async {
    if (!_initialized) {
      await init();
    }

    final currentList = purchases.value;

    // Reassigning with List<Ad>.from creates a completely new array instance in memory
    // Ensuring that ValueNotifier explicitly recognizes the change and rebuilds UI
    purchases.value = List<Ad>.from(currentList)..insert(0, ad);

    await _saveToDisk();
  }

  // Helper function to save
  Future<void> _saveToDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData =
          jsonEncode(purchases.value.map((ad) => ad.toJson()).toList());

      await prefs.setString('purchased_ads', encodedData);
    } catch (e) {
      debugPrint("Error saving purchases: $e");
    }
  }
}
