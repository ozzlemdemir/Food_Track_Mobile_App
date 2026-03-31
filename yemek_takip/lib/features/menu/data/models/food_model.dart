import '../../../../core/entities/food_entry.dart';

class FoodModel {
  final String id;
  final String dayName;
  final List<String> meals;
  final double rating;
  final String dateStr;

  FoodModel({
    required this.id,
    required this.dayName,
    required this.meals,
    required this.rating,
    required this.dateStr,
  });

  // JSON → FoodModel
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      dayName: json['dayName'] as String,
      meals: List<String>.from(json['meals']),
      rating: (json['rating'] as num).toDouble(),
      dateStr: json['date'] as String,
    );
  }

  // FoodModel → FoodEntry
  FoodEntry toEntity() {
    return FoodEntry(
      id: id,
      dayName: dayName,
      meals: meals,
      rating: rating,
      date: DateTime.parse(dateStr),
    );
  }
}