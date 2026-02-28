import 'package:flutter/material.dart';
import '../domain/food_entry.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock veri — Firebase bağlanınca burası değişecek
  static final List<FoodEntry> mockMenu = [
    FoodEntry(
      id: '1',
      dayName: 'Pazartesi',
      meals: ['Mercimek Çorbası', 'Tavuk Sote', 'Pilav', 'Ayran'],
      rating: 4.2,
      date: DateTime(2026, 2, 24),
    ),
    FoodEntry(
      id: '2',
      dayName: 'Salı',
      meals: ['Ezogelin Çorbası', 'Köfte', 'Bulgur Pilavı', 'Sütlaç'],
      rating: 4.5,
      date: DateTime(2026, 2, 25),
    ),
    FoodEntry(
      id: '3',
      dayName: 'Çarşamba',
      meals: ['Tarhana Çorbası', 'Balık', 'Patates', 'Meyve'],
      rating: 3.8,
      date: DateTime(2026, 2, 26),
    ),
    FoodEntry(
      id: '4',
      dayName: 'Perşembe',
      meals: ['Yoğurt Çorbası', 'Et Sote', 'Makarna', 'Komposto'],
      rating: 4.0,
      date: DateTime(2026, 2, 27),
    ),
    FoodEntry(
      id: '5',
      dayName: 'Cuma',
      meals: ['Şehriye Çorbası', 'Tavuk Izgara', 'Pirinç', 'Baklava'],
      rating: 4.3,
      date: DateTime(2026, 2, 28),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text(
          'Bu Haftanın Menüsü',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockMenu.length,
        itemBuilder: (context, index) {
          final entry = mockMenu[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(entry: entry),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Row(
                children: [
                  // Sol renkli çizgi
                  Container(
                    width: 4,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.dayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          entry.mealsPreview,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Puan
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: entry.isHighlyRated
                          ? const Color(0xFFFF6B35)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${entry.rating}',
                      style: TextStyle(
                        color: entry.isHighlyRated
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFF6B35),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menü'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoriler'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}