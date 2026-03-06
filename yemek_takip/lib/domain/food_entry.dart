class FoodEntry {
  final String id;
  final String dayName;        
  final List<String> meals;    // menü
  final double rating;
  final DateTime date;
  final int? capacity;
  final String? imageUrl;

  const FoodEntry({
    required this.id,
    required this.dayName,
    required this.meals,
    required this.rating,
    required this.date,
    this.capacity,
    this.imageUrl,
  });

// Tarihi GG/AA formatında gösterir
  String get dateShort =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}';

  // Y+ ten yüksek puanl yemekler için true döner
  bool get isHighlyRated => rating >= 4.0;

  // Yemekleri tek satırda göster (özet için)
  String get mealsPreview => meals.take(3).join(', ');
}