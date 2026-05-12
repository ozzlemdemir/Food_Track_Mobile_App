import 'package:firebase_auth/firebase_auth.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

// Hata sınıfı
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  // Hata kodlarını Türkçe mesaja çevir
  String _authMessage(String code) => switch (code) {
        'user-not-found' => 'Bu e-posta ile kayıtlı kullanıcı bulunamadı.',
        'wrong-password' => 'Hatalı şifre.',
        'email-already-in-use' => 'Bu e-posta zaten kullanımda.',
        'weak-password' => 'Şifre en az 6 karakter olmalı.',
        'invalid-email' => 'Geçersiz e-posta adresi.',
        'network-request-failed' => 'İnternet bağlantısı hatası.',
        'too-many-requests' => 'Çok fazla deneme, lütfen bekleyin.',
        'invalid-credential' => 'E-posta veya şifre hatalı.',
        _ => 'Bir hata oluştu: $code',
      };

  @override
  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().map(
          (user) =>
              user != null ? AppUser.fromFirebaseUser(user) : null,
        );
  }

  @override
  AppUser? get currentUser {
    final user = _auth.currentUser;
    return user != null ? AppUser.fromFirebaseUser(user) : null;
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser.fromFirebaseUser(cred.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_authMessage(e.code));
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser.fromFirebaseUser(cred.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_authMessage(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}