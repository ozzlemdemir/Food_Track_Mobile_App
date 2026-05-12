import '../domain/app_user.dart';

abstract interface class AuthRepository {
  // Oturum durumu stream'i
  Stream<AppUser?> get authStateChanges;

  // Giriş yap
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password);

  // Kayıt ol
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password);

  // Çıkış yap
  Future<void> signOut();

  // Anlık kullanıcı
  AppUser? get currentUser;
}