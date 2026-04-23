import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

class MenuDao {
  final AppDatabase _db;

  MenuDao(this._db);

  static const String _table = 'menus';

  // Tüm menüleri kaydet (toplu)
  Future<void> insertAll(List<Map<String, dynamic>> menus) async {
    final db = await _db.database;
    final batch = db.batch();

    for (final menu in menus) {
      batch.insert(
        _table,
        menu,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // Tüm menüleri oku
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await _db.database;
    return db.query(_table);
  }

  // Tüm menüleri sil
  Future<void> deleteAll() async {
    final db = await _db.database;
    await db.delete(_table);
  }
}