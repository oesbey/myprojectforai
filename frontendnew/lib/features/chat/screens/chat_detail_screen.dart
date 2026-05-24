import 'package:flutter/material.dart';
import 'package:runo_live/features/chat/models/chat_models.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatListModel chatData;

  const ChatDetailScreen({super.key, required this.chatData});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  // Örnek mesaj geçmişi
  final List<ChatMessageModel> messages = [
    ChatMessageModel(
        id: "1",
        text: "Selam! Odaya gelecek misin?",
        isMe: false,
        time: "22:00"),
    ChatMessageModel(
        id: "2",
        text: "Evet, birazdan katılıyorum.",
        isMe: true,
        time: "22:05"),
    ChatMessageModel(
        id: "3",
        text: "",
        imageUrl:
            "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=400&auto=format&fit=crop",
        isMe: false,
        time: "22:08"),
    ChatMessageModel(
        id: "4", text: "Harika görünüyor! 🎉", isMe: true, time: "22:10"),
    ChatMessageModel(
        id: "5", text: "Bekliyorum o zaman.", isMe: false, time: "22:11"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Ferah arka plan
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // MESAJLAR LİSTESİ
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _ChatBubble(message: messages[index]);
              },
            ),
          ),
          // MESAJ YAZMA ALANI
          _buildFloatingInputBar(),
        ],
      ),
    );
  }

  // --- ÜST BAR ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(widget.chatData.avatarUrl),
              radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatData.name,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1),
                const Text("Çevrimiçi",
                    style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.phone, color: Colors.black87),
            onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {}),
      ],
    );
  }

  // --- MESAJ YAZMA ALANI ---
  Widget _buildFloatingInputBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFF0F2F5),
              child: Icon(Icons.mic, color: Colors.black87),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Bir mesaj yaz...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.sentiment_satisfied_alt,
                    color: Colors.grey),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
                onPressed: () {}),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF00E5FF), // Uygulamanın ana turkuaz rengi
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SADE VE NET MESAJ BALONCUĞU ---
class _ChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // ELI5: Gönderen biz isek açık ferah bir mavi/turkuaz, karşı tarafsa beyaz.
    final bgColor = message.isMe ? const Color(0xFFD4FCFB) : Colors.white;
    // ELI5: Yazı rengi her iki taraf için de net siyah/koyu gri. Beyaz karmaşası bitti.
    final textColor = Colors.black87;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: EdgeInsets.all(message.imageUrl != null ? 4 : 12),
            decoration: BoxDecoration(
              color: bgColor, // Dümdüz ve sade arka plan rengi
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(message.isMe ? 16 : 0),
                bottomRight: Radius.circular(message.isMe ? 0 : 16),
              ),
              boxShadow: [
                // Sadece karşı tarafın beyaz balonunda çok hafif bir ayrım gölgesi var.
                // Bizim renkli balonumuzda "bulutsu" gölge falan yok, dümdüz.
                if (!message.isMe)
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1)),
              ],
            ),
            child: message.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(message.imageUrl!, fit: BoxFit.cover),
                  )
                : Text(
                    message.text,
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
          ),
          const SizedBox(height: 4),
          Text(message.time,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
