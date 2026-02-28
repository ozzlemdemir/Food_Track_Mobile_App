class FoodEntry {
  final String id;
  final String dayName;        // Pazartesi, Salı...
  final List<String> meals;    // yemek isimleri
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

  // Tarih formatı getter
  String get dateShort =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}';

  // Yüksek puanlı mı?
  bool get isHighlyRated => rating >= 4.0;

  // Yemekleri tek satırda göster
  String get mealsPreview => meals.take(3).join(', ');
}