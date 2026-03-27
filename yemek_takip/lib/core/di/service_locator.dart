import '../../features/menu/data/datasources/menu_datasource.dart';
import '../../features/menu/data/repositories/mock_menu_repository.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/presentation/viewmodels/menu_viewmodel.dart';

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

  void setup() {
    register<MenuRepository>(
      MockMenuRepository(MenuDataSource()),
    );
    register<MenuViewModel>(
      MenuViewModel(get<MenuRepository>()),
    );
  }
}