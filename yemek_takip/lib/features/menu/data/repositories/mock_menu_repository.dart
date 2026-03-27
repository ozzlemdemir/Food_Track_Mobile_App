import '../../../../core/entities/food_entry.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_datasource.dart';

class MockMenuRepository implements MenuRepository {
  final MenuDataSource dataSource;

  MockMenuRepository(this.dataSource);

  @override
  Future<List<FoodEntry>> getMenus() async {
    try {
      final models = await dataSource.getMenus();
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw ServerException('Menüler yüklenemedi: $e');
    }
  }

  @override
  Future<FoodEntry> getMenuById(String id) async {
    try {
      final models = await dataSource.getMenus();
      final model = models.firstWhere(
        (m) => m.id == id,
        orElse: () => throw NotFoundException('Menü bulunamadı: $id'),
      );
      return model.toEntity();
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw ServerException('Hata: $e');
    }
  }
}
