import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/app_user.dart';
import 'auth_view_model.dart';
import '../../../screens/home_screen.dart';
import '../../../screens/login_screen.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return StreamBuilder<AppUser?>(
      stream: authVm.authStateChanges,
      builder: (context, snapshot) {
        // Firebase kontrol ederken bekle
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF6B35),
              ),
            ),
          );
        }

        // Giriş yapılmışsa HomeScreen
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        // Giriş yapılmamışsa LoginScreen
        return const LoginScreen();
      },
    );
  }
}