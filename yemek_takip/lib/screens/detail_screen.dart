import 'package:flutter/material.dart';
import '../domain/food_entry.dart';

class DetailScreen extends StatelessWidget {
  final FoodEntry entry;

  const DetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        title: Text(
          '${entry.dayName} Menüsü',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarih
            Center(
              child: Text(
                entry.dateShort,
                style:
                    const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),

            // Yemek listesi
            ...entry.meals.map(
              (meal) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant_menu,
                        color: Color(0xFFFF6B35), size: 20),
                    const SizedBox(width: 12),
                    Text(meal,
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Puan ver
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Puan Ver:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < entry.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(0xFFFF6B35),
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Yorum butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.comment_outlined,
                    color: Colors.white),
                label: const Text(
                  'Yorum Yaz',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}