import '../models/food_model.dart';

class MenuDataSource {
  Future<List<FoodModel>> getMenus() async {
    // Gerçek API'yi simüle etmek için küçük gecikme
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      FoodModel(
        id: '1',
        dayName: 'Pazartesi',
        meals: ['Mercimek Çorbası', 'Tavuk Sote', 'Pilav', 'Ayran'],
        rating: 4.2,
        dateStr: '2026-02-24',
      ),
      FoodModel(
        id: '2',
        dayName: 'Salı',
        meals: ['Ezogelin Çorbası', 'Köfte', 'Bulgur Pilavı', 'Sütlaç'],
        rating: 4.5,
        dateStr: '2026-02-25',
      ),
      FoodModel(
        id: '3',
        dayName: 'Çarşamba',
        meals: ['Tarhana Çorbası', 'Balık', 'Patates', 'Meyve'],
        rating: 3.8,
        dateStr: '2026-02-26',
      ),
      FoodModel(
        id: '4',
        dayName: 'Perşembe',
        meals: ['Yoğurt Çorbası', 'Et Sote', 'Makarna', 'Komposto'],
        rating: 4.0,
        dateStr: '2026-02-27',
      ),
      FoodModel(
        id: '5',
        dayName: 'Cuma',
        meals: ['Şehriye Çorbası', 'Tavuk Izgara', 'Pirinç', 'Baklava'],
        rating: 4.3,
        dateStr: '2026-02-28',
      ),
    ];
  }
}