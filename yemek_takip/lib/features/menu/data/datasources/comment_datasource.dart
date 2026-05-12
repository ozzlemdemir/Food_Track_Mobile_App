import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/entities/comment.dart';
import '../../../../core/errors/app_exception.dart';

class CommentDataSource {
  final FirebaseFirestore _firestore;

  CommentDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Yorum ekle
  Future<void> addComment({
    required String menuId,
    required String userName,
    required String text,
    required int rating,
  }) async {
    try {
      await _firestore
          .collection('menus')
          .doc(menuId)
          .collection('comments')
          .add({
        'menuId': menuId,
        'userName': userName,
        'text': text,
        'rating': rating,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw NetworkException('Yorum eklenemedi: ${e.message}');
    }
  }

  // Yorumları getir
  Future<List<Comment>> getComments(String menuId) async {
    try {
      final snap = await _firestore
          .collection('menus')
          .doc(menuId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();

      return snap.docs.map((doc) {
        final data = doc.data();
        return Comment(
          id: doc.id,
          menuId: data['menuId'] as String,
          userName: data['userName'] as String,
          text: data['text'] as String,
          rating: data['rating'] as int,
          createdAt: DateTime.parse(data['createdAt'] as String),
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw NetworkException('Yorumlar alınamadı: ${e.message}');
    }
  }
}