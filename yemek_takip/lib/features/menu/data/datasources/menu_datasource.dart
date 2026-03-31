import 'dart:convert';
import '../models/food_model.dart';

class MenuDataSource {
  // Bellekte cache
  List<FoodModel>? _cache;

  // Sanki sunucudan JSON geliyormuş gibi simüle ediyoruz
  static const String _mockJsonData = '''
  [
    {
      "id": "1",
      "dayName": "Pazartesi",
      "meals": ["Mercimek Çorbası", "Tavuk Sote", "Pilav", "Ayran"],
      "rating": 4.2,
      "date": "2026-02-24"
    },
    {
      "id": "2",
      "dayName": "Salı",
      "meals": ["Ezogelin Çorbası", "Köfte", "Bulgur Pilavı", "Sütlaç"],
      "rating": 4.5,
      "date": "2026-02-25"
    },
    {
      "id": "3",
      "dayName": "Çarşamba",
      "meals": ["Tarhana Çorbası", "Balık", "Patates", "Meyve"],
      "rating": 3.8,
      "date": "2026-02-26"
    },
    {
      "id": "4",
      "dayName": "Perşembe",
      "meals": ["Yoğurt Çorbası", "Et Sote", "Makarna", "Komposto"],
      "rating": 4.0,
      "date": "2026-02-27"
    },
    {
      "id": "5",
      "dayName": "Cuma",
      "meals": ["Şehriye Çorbası", "Tavuk Izgara", "Pirinç", "Baklava"],
      "rating": 4.3,
      "date": "2026-02-28"
    }
  ]
  ''';

  Future<List<FoodModel>> getMenus() async {
    // Cache varsa direkt döndür
    if (_cache != null) {
      return _cache!;
    }

    // API gecikmesini simüle et
    await Future.delayed(const Duration(milliseconds: 800));

    // JSON string → List<Map> → List<FoodModel>
    final List<dynamic> jsonList = jsonDecode(_mockJsonData);
    final models = jsonList
        .map((json) => FoodModel.fromJson(json as Map<String, dynamic>))
        .toList();

    // Cache'e kaydet
    _cache = models;

    return models;
  }

  // Cache'i temizle (yenile butonu için)
  void clearCache() {
    _cache = null;
  }
}