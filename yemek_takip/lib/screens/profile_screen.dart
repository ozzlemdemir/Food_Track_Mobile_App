import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/auth_view_model.dart';
import 'comments_list_screen.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final user = authVm.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text('Profilim',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFFF6B35),
              child: Text(
                user?.initials ?? '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // İsim
            Text(
              user?.displayName ?? 'Kullanıcı',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Email
            Text(
              user?.email ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Menü öğeleri
            ListTile(
              leading: Icon(Icons.comment_outlined,
                  color: Colors.grey[600]),
              title: const Text('Yorumlarım'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CommentsListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline,
                  color: Colors.grey[600]),
              title: const Text('Favori Menülerim'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const FavoritesScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined,
                  color: Colors.grey[600]),
              title: const Text('Ayarlar'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SettingsScreen()),
                );
              },
            ),

            const Divider(),

            // Çıkış yap
            ListTile(
              leading:
                  const Icon(Icons.logout, color: Color(0xFFFF6B35)),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(color: Color(0xFFFF6B35)),
              ),
              onTap: () async {
  await context.read<AuthViewModel>().signOut();
  if (context.mounted) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }
},
            ),
          ],
        ),
      ),
    );
  }
}