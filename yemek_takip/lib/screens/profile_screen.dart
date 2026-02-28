import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const Text('ÖD',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            const Text('Özlem Demir',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('436538@ktu.edu.tr',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),

            // İstatistikler
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statCard('12', 'Yorum'),
                _statCard('45', 'Favori'),
                _statCard('4.2', 'Ort. Puan'),
              ],
            ),
            const SizedBox(height: 24),

            // Menü öğeleri
            _menuItem(Icons.comment_outlined, 'Yorumlarım'),
            _menuItem(Icons.favorite_outline, 'Favori Menülerim'),
            _menuItem(Icons.notifications_outlined, 'Bildirim Ayarları'),
            _menuItem(Icons.settings_outlined, 'Ayarlar'),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFFF6B35)),
              title: const Text('Çıkış Yap',
                  style: TextStyle(color: Color(0xFFFF6B35))),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}