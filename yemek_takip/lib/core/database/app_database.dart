import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // Singleton — tek bağlantı
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'yemek_takip.db');

    return openDatabase(
      path,
      version: 1,
      // WAL modu — yazarken okuma bloklanmaz
      onConfigure: (db) async {
        await db.execute('PRAGMA journal_mode=WAL');
      },
      // İlk açılışta tablo oluştur
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE menus (
            id TEXT PRIMARY KEY,
            day_name TEXT NOT NULL,
            meals TEXT NOT NULL,
            rating REAL NOT NULL,
            date TEXT NOT NULL,
            cached_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}