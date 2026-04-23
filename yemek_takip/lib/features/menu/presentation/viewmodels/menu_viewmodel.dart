import 'package:flutter/material.dart';
import '../../../../core/entities/food_entry.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/menu_repository.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository repository;
  final ConnectivityChecker connectivityChecker;

  MenuViewModel(this.repository, this.connectivityChecker);

  List<FoodEntry> _allMenus = [];
  bool _isLoading = false;
  String? _error;
  String? _selectedDay;
  bool _isOffline = false;

  List<FoodEntry> get filteredMenus {
    if (_selectedDay == null) return _allMenus;
    return _allMenus.where((e) => e.dayName == _selectedDay).toList();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedDay => _selectedDay;
  bool get isOffline => _isOffline;

  Future<void> loadMenus() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // İnternet durumunu kontrol et
    _isOffline = !(await connectivityChecker.isConnected);

    try {
      _allMenus = await repository.getMenus();
    } on NetworkException catch (e) {
      _error = 'İnternet bağlantısı yok: ${e.message}';
    } on NotFoundException catch (e) {
      _error = e.message;
    } on ServerException catch (e) {
      _error = 'Sunucu hatası: ${e.message}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMenus() async {
    repository.clearCache();
    await loadMenus();
  }

  void filterByDay(String? day) {
    _selectedDay = day;
    notifyListeners();
  }

  void clearFilter() {
    _selectedDay = null;
    notifyListeners();
  }
}