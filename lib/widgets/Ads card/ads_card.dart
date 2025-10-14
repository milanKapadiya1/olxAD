import 'package:flutter/material.dart';
import 'package:olxad/model/ad_model.dart';

class AdCard extends StatelessWidget {
  
  final Ad ad;

  const AdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            
            child: Image.network(
              
              ad.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  ad.desc,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 49, 49, 49)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text('Price :', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                    Text(ad.price.toString(),
                        style: const TextStyle(
                            fontSize: 14, color: Color.fromARGB(255, 49, 49, 49))),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(ad.location,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 49, 49, 49))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
