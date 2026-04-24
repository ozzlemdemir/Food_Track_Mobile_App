import '../../../../core/database/menu_dao.dart';
import '../../../../core/entities/food_entry.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/firebase_menu_datasource.dart';
import '../models/food_model.dart';

class OfflineFirstMenuRepository implements MenuRepository {
  final FirebaseMenuDataSource dataSource;
  final MenuDao menuDao;
  final ConnectivityChecker connectivityChecker;

  OfflineFirstMenuRepository({
    required this.dataSource,
    required this.menuDao,
    required this.connectivityChecker,
  });

  @override
  Future<List<FoodEntry>> getMenus() async {
    final connected = await connectivityChecker.isConnected;

    if (connected) {
      try {
        final models = await dataSource.getMenus();
        await menuDao.insertAll(
          models.map((m) => m.toMap()).toList(),
        );
        return models.map((m) => m.toEntity()).toList();
      } catch (e) {
        return await _getFromLocal();
      }
    } else {
      return await _getFromLocal();
    }
  }

  Future<List<FoodEntry>> _getFromLocal() async {
    try {
      final maps = await menuDao.queryAll();
      if (maps.isEmpty) {
        throw NotFoundException(
            'Kayıtlı veri bulunamadı. İnternet bağlantısı gerekli.');
      }
      return maps.map((m) => FoodModel.fromMap(m).toEntity()).toList();
    } catch (e) {
      throw ServerException('Yerel veri okunamadı: $e');
    }
  }

  @override
  Future<FoodEntry> getMenuById(String id) async {
    final menus = await getMenus();
    return menus.firstWhere(
      (m) => m.id == id,
      orElse: () => throw NotFoundException('Menü bulunamadı: $id'),
    );
  }

  @override
  void clearCache() {}
}