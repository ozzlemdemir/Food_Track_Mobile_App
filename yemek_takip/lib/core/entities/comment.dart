class Comment {
  final String id;
  final String menuId;
  final String userName;
  final String text;
  final int rating;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.menuId,
    required this.userName,
    required this.text,
    required this.rating,
    required this.createdAt,
  });
}