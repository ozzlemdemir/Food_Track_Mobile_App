import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/food_model.dart';

class FirebaseMenuDataSource {
  final FirebaseFirestore _firestore;

  FirebaseMenuDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<FoodModel>> getMenus() async {
    try {
      final snap = await _firestore.collection('menus').get();

      return snap.docs.map((doc) {
        final data = doc.data();
        return FoodModel.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    } on FirebaseException catch (e) {
      throw NetworkException('Firestore hatası: ${e.message}');
    }
  }
}