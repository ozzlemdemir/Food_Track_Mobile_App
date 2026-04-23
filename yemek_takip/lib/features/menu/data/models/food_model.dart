import 'dart:convert';
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

  // JSON → FoodModel (API'den gelen veri)
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      dayName: json['dayName'] as String,
      meals: List<String>.from(json['meals']),
      rating: (json['rating'] as num).toDouble(),
      dateStr: json['date'] as String,
    );
  }

  // SQLite satırı → FoodModel
  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] as String,
      dayName: map['day_name'] as String,
      // meals TEXT olarak kaydedildi, geri çeviriyoruz
      meals: List<String>.from(jsonDecode(map['meals'] as String)),
      rating: map['rating'] as double,
      dateStr: map['date'] as String,
    );
  }

  // FoodModel → SQLite satırı
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day_name': dayName,
      // List<String> SQLite'a kaydedilemez, JSON string'e çeviriyoruz
      'meals': jsonEncode(meals),
      'rating': rating,
      'date': dateStr,
      'cached_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  // FoodModel → FoodEntry (Domain nesnesi)
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