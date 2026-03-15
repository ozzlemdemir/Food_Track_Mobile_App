import 'package:flutter/material.dart';
import '../domain/food_entry.dart';

class MenuProvider extends ChangeNotifier {
  // Tüm mock veri burada — artık HomeScreen'de değil
  final List<FoodEntry> _allMenus = [
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

  // Seçili filtre — null ise tümü göster
  String? _selectedDay;

  String? get selectedDay => _selectedDay;

  // Filtrelenmiş liste
  List<FoodEntry> get filteredMenus {
    if (_selectedDay == null) return _allMenus;
    return _allMenus
        .where((e) => e.dayName == _selectedDay)
        .toList();
  }

  // Filtre değiştir
  void filterByDay(String? day) {
    _selectedDay = day;
    notifyListeners(); // ekranları güncelle
  }

  // Filtreyi temizle
  void clearFilter() {
    _selectedDay = null;
    notifyListeners();
  }
}