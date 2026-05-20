// ELI5: Hikayelerin ve Gönderilerin (Post) veri kalıpları. İleride bunlar sunucudan gelecek.
class StoryModel {
  final String id;
  final String userName;
  final String avatarUrl;
  final List<String> imageUrls; // Bir kişinin birden fazla hikayesi olabilir
  final bool isViewed; // İzlenip izlenmediğini anlamak için

  StoryModel({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.imageUrls,
    this.isViewed = false,
  });
}

class PostModel {
  final String id;
  final String userName;
  final String avatarUrl;
  final String level;
  final String contentText;
  final List<String> imageUrls; // Gönderideki resimler
  final String date;
  final int likeCount;
  final int commentCount;
  final bool isPinned; // Sabitlenmiş gönderi mi?

  PostModel({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.level,
    required this.contentText,
    required this.imageUrls,
    required this.date,
    required this.likeCount,
    required this.commentCount,
    this.isPinned = false,
  });
}
