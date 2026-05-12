class AppUser {
  final String uid;
  final String email;
  final String? displayName;

  const AppUser({
    required this.uid,
    required this.email,
    this.displayName,
  });

  factory AppUser.fromFirebaseUser(dynamic user) {
    return AppUser(
      uid: user.uid as String,
      email: user.email as String? ?? '',
      displayName: user.displayName as String?,
    );
  }

  // Profil sayfasında avatar için baş harfler
  String get initials {
    if (displayName != null && displayName!.isNotEmpty) {
      final parts = displayName!.trim().split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    if (email.isNotEmpty) return email[0].toUpperCase();
    return '?';
  }
}