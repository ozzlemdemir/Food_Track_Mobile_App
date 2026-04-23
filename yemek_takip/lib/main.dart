import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'features/menu/presentation/viewmodels/menu_viewmodel.dart';
import 'screens/login_screen.dart';

void main() async {
  // Flutter motorunun hazır olmasını bekle
  WidgetsFlutterBinding.ensureInitialized();

  // ServiceLocator async oldu (DB bekleniyor)
  await ServiceLocator().setup();

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ServiceLocator().get<MenuViewModel>()..loadMenus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KTÜ Yemekhane',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}