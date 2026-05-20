// ELI5: Bu dosya bizim sohbet verilerimizin kalıbıdır.
class ChatListModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarUrl;
  final bool isOfficial; // Resmi hesap mı? (Yetkili vs)

  ChatListModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    required this.avatarUrl,
    this.isOfficial = false,
  });
}

class ChatMessageModel {
  final String id;
  final String text;
  final String? imageUrl; // Eğer resim atılmışsa burası dolu olur
  final bool isMe; // Mesajı ben mi attım?
  final String time;

  ChatMessageModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.isMe,
    required this.time,
  });
}
