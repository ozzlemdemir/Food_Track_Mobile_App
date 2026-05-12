import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/entities/food_entry.dart';
import '../../../../core/errors/app_exception.dart';

class FavoriteDataSource {
  final FirebaseFirestore _firestore;

  FavoriteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Giriş yapan kullanıcının ID'si
  String get _userId {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Kullanıcı giriş yapmamış.');
    return user.uid;
  }

  // Favoriye ekle
  Future<void> addFavorite(FoodEntry entry) async {
    try {
      await _firestore
          .collection('favorites')
          .doc(_userId)
          .collection('menus')
          .doc(entry.id)
          .set({
        'dayName': entry.dayName,
        'date': entry.dateShort,
        'rating': entry.rating,
        'meals': entry.meals,
        'addedAt': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw NetworkException('Favoriye eklenemedi: ${e.message}');
    }
  }

  // Favoriden çıkar
  Future<void> removeFavorite(String menuId) async {
    try {
      await _firestore
          .collection('favorites')
          .doc(_userId)
          .collection('menus')
          .doc(menuId)
          .delete();
    } on FirebaseException catch (e) {
      throw NetworkException('Favoriden çıkarılamadı: ${e.message}');
    }
  }

  // Favori mi kontrol et
  Future<bool> isFavorite(String menuId) async {
    try {
      final doc = await _firestore
          .collection('favorites')
          .doc(_userId)
          .collection('menus')
          .doc(menuId)
          .get();
      return doc.exists;
    } on FirebaseException catch (e) {
      throw NetworkException('Kontrol edilemedi: ${e.message}');
    }
  }

  // Tüm favorileri getir
  Future<List<FoodEntry>> getFavorites() async {
    try {
      final snap = await _firestore
          .collection('favorites')
          .doc(_userId)
          .collection('menus')
          .orderBy('addedAt', descending: true)
          .get();

      return snap.docs.map((doc) {
        final data = doc.data();
        return FoodEntry(
          id: doc.id,
          dayName: data['dayName'] as String,
          meals: List<String>.from(data['meals']),
          rating: (data['rating'] as num).toDouble(),
          date: DateTime.now(),
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw NetworkException('Favoriler alınamadı: ${e.message}');
    }
  }
}