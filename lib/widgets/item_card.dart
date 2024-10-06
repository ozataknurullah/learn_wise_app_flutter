import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? imageUrl;
  final String title;

  ItemCard({this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image bölümü: imageUrl boşsa yer tutucu gösterilecek
          imageUrl != null && imageUrl!.isNotEmpty
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                )
              : Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300], // Boş durum için arka plan rengi
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
