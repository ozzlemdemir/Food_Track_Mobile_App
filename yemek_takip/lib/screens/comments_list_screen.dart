import 'package:flutter/material.dart';
import '../features/menu/data/datasources/comment_datasource.dart';
import '../core/entities/comment.dart';
import '../core/di/service_locator.dart';
import '../features/menu/domain/repositories/menu_repository.dart';

class CommentsListScreen extends StatefulWidget {
  const CommentsListScreen({super.key});

  @override
  State<CommentsListScreen> createState() => _CommentsListScreenState();
}

class _CommentsListScreenState extends State<CommentsListScreen> {
  final CommentDataSource _dataSource = CommentDataSource();
  List<Comment> _comments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllComments();
  }

  Future<void> _loadAllComments() async {
    List<Comment> allComments = [];
    
    try {
      final repository = ServiceLocator().get<MenuRepository>();
      final menus = await repository.getMenus();
      final menuIds = menus.map((m) => m.id).toList();

      for (final menuId in menuIds) {
        try {
          final comments = await _dataSource.getComments(menuId);
          // Sadece 'Kullanıcı'nın yorumlarını filtrele
          allComments.addAll(comments.where((c) => c.userName == 'Kullanıcı'));
        } catch (_) {}
      }

      // Tüm yorumları tarihe göre en yeniden en eskiye sırala
      allComments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      // Hata olursa boş liste gösterilir
    }

    if (mounted) {
      setState(() {
        _comments = allComments;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text(
          'Yorumlarım',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF6B35),
              ),
            )
          : _comments.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment_outlined,
                          size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Henüz yorum yapmadınız.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xFFFF6B35)
                                    .withOpacity(0.15),
                                child: Text(
                                  comment.userName[0],
                                  style: const TextStyle(
                                    color: Color(0xFFCC4400),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  comment.userName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    i < comment.rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: const Color(0xFFFF6B35),
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(comment.text),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}