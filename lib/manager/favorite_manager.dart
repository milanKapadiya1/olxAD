import 'dart:convert'; // Needed for JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import this
import 'package:olxad/model/ad_model.dart';

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  final ValueNotifier<List<Ad>> favorites = ValueNotifier<List<Ad>>([]);

  // 1. NEW: Initialize method to load saved data
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedString = prefs.getString('liked_ads');

    if (savedString != null) {
      // Convert the Text back into a List of Ad Objects
      final List<dynamic> decodedList = jsonDecode(savedString);
      final List<Ad> loadedAds = decodedList.map((item) => Ad.fromJson(item)).toList();
      
      favorites.value = loadedAds;
    }
  }

  // 2. Updated Toggle Logic (Now Saves to Disk)
  Future<void> toggleFavorite(Ad ad) async {
    final currentList = favorites.value;
    final isExisting = currentList.any((element) => element.title == ad.title);

    if (isExisting) {
      favorites.value = List.from(currentList)..removeWhere((element) => element.title == ad.title);
    } else {
      favorites.value = List.from(currentList)..add(ad);
    }

    // 3. SAVE TO DISK IMMEDIATELY
    _saveToDisk();
  }

  // Helper function to save
  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert List<Ad> -> List<Map> -> String (JSON)
    final String encodedData = jsonEncode(
      favorites.value.map((ad) => ad.toJson()).toList()
    );
    
    await prefs.setString('liked_ads', encodedData);
  }

  bool isLiked(Ad ad) {
    return favorites.value.any((element) => element.title == ad.title);
  }
}