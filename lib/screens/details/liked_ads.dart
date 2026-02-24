import 'package:flutter/material.dart';
import 'package:olxad/manager/favorite_manager.dart';
import 'package:olxad/model/ad_model.dart';
import 'package:olxad/model/like_ui_tile.dart';
import 'package:olxad/util/app_theme.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      
      // Listen to the Manager
      body: ValueListenableBuilder<List<Ad>>(
        valueListenable: FavoriteManager().favorites,
        builder: (context, favList, child) {
          
          if (favList.isEmpty) {
            return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border,
                  size: 64, color: AppTheme.textSecondary.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              Text(
                "You don't have any liked items",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
        );
          }
        
          return ListView.builder(
            itemCount: favList.length,
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
              return Likeuitile(ads: favList[index]);
            },
          );
        },
      ),
    );
  }
}
