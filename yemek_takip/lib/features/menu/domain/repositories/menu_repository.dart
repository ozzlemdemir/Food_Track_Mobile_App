import '../../../../core/entities/food_entry.dart';

abstract class MenuRepository {
  Future<List<FoodEntry>> getMenus();
  Future<FoodEntry> getMenuById(String id);
  void clearCache();
}