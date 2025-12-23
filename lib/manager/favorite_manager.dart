import 'package:flutter/material.dart';
import 'package:olxad/model/ad_model.dart';

class FavoriteManager {
  FavoriteManager._internal(); // this is constructor 
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  // FavoriteManager._internal(){} its same write {} or ;

  final ValueNotifier<List<Ad>> favorites = ValueNotifier<List<Ad>>([]);

  void toggleFavorite(Ad ad) {
    final currentList = favorites.value;
    // checking id/title
    final isExisting = currentList.any((element) => element.title == ad.title);

    if (isExisting) {
      favorites.value = List.from(currentList)..removeWhere((element) => element.title == ad.title);
    } else {
      favorites.value = List.from(currentList)..add(ad);
    }
  }

  bool isLiked(Ad ad) {
    return favorites.value.any((element) => element.title == ad.title);
  }
}