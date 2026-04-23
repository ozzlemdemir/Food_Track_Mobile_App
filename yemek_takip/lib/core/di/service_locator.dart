import 'package:flutter/foundation.dart';
import '../../features/menu/data/datasources/menu_datasource.dart';
import '../../features/menu/data/repositories/mock_menu_repository.dart';
import '../../features/menu/data/repositories/offline_first_menu_repository.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/presentation/viewmodels/menu_viewmodel.dart';
import '../database/app_database.dart';
import '../database/menu_dao.dart';
import '../network/connectivity_checker.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  final Map<String, dynamic> _services = {};

  ServiceLocator._internal();

  factory ServiceLocator() => _instance;

  void register<T>(T service) {
    _services[T.toString()] = service;
  }

  T get<T>() {
    return _services[T.toString()] ??
        (throw Exception('$T kayıtlı değil'));
  }

  Future<void> setup() async {
    final connectivityChecker = ConnectivityChecker();

    if (kIsWeb) {
      // Web'de SQLite çalışmaz, mock repository kullan
      register<MenuRepository>(
        MockMenuRepository(MenuDataSource()),
      );
    } else {
      // Android/iOS'ta SQLite kullan
      final db = AppDatabase.instance;
      final menuDao = MenuDao(db);

      register<MenuRepository>(
        OfflineFirstMenuRepository(
          dataSource: MenuDataSource(),
          menuDao: menuDao,
          connectivityChecker: connectivityChecker,
        ),
      );
    }

    register<MenuViewModel>(
      MenuViewModel(
        get<MenuRepository>(),
        connectivityChecker,
      ),
    );
  }
}