import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();
    final menus = provider.filteredMenus;
    final selectedDay = provider.selectedDay;

    final days = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'];

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
      body: Column(
        children: [
          // Filtre butonları
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              children: [
                // Tümü butonu
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('Tümü'),
                    selected: selectedDay == null,
                    onSelected: (_) => provider.clearFilter(),
                    selectedColor: const Color(0xFFFF6B35),
                    labelStyle: TextStyle(
                      color: selectedDay == null
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                // Gün butonları
                ...days.map((day) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(day),
                        selected: selectedDay == day,
                        onSelected: (_) => provider.filterByDay(day),
                        selectedColor: const Color(0xFFFF6B35),
                        labelStyle: TextStyle(
                          color: selectedDay == day
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )),
              ],
            ),
          ),

          // Menü listesi
          Expanded(
            child: menus.isEmpty
                ? const Center(child: Text('Sonuç bulunamadı.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      final entry = menus[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailScreen(entry: entry),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                          color: Colors.grey,
                                          fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFF6B35),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Menü'),
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