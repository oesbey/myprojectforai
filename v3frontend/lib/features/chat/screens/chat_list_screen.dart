import 'package:flutter/material.dart';
import 'package:runo_live/features/chat/models/chat_models.dart';
import 'package:runo_live/features/chat/screens/chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // ELI5: Sahte sohbet listemiz
  final List<ChatListModel> chats = [
    ChatListModel(
        id: "1",
        name: "Sistem Yetkilisi",
        lastMessage: "Hesabınız başarıyla onaylandı.",
        time: "12:45",
        unreadCount: 1,
        avatarUrl: "https://i.pravatar.cc/150?img=11",
        isOfficial: true),
    ChatListModel(
        id: "2",
        name: "✨ KiRAZ 🕊️",
        lastMessage: "Akşam odaya bekliyorum :)",
        time: "11:30",
        unreadCount: 3,
        avatarUrl: "https://i.pravatar.cc/150?img=5"),
    ChatListModel(
        id: "3",
        name: "Luke Hobbs",
        lastMessage: "Payton hediyesi için teşekkürler!",
        time: "Dün",
        avatarUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_S-GfE_7XFp_7zS0vL5K1Y6Y3_2_2_2_2"),
    ChatListModel(
        id: "4",
        name: "Birlik Grubu",
        lastMessage: "Ahmet: Yarın PK var unutmayın.",
        time: "Pzt",
        avatarUrl: "https://i.pravatar.cc/150?img=33"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Mesajlar",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: const Icon(Icons.person_add_alt_1, color: Colors.black),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.black),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // ARAMA ÇUBUĞU
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 45,
              decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  const Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ara...", border: InputBorder.none))),
                  Icon(Icons.mic_none, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),

          // SOHBET LİSTESİ
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return _buildChatListItem(context, chats[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- SOHBET LİSTESİ ELEMANI ---
  Widget _buildChatListItem(BuildContext context, ChatListModel chat) {
    // ELI5: Tıklanabilirlik katmak için InkWell ile sardık
    return InkWell(
      onTap: () {
        // Tıklayınca Detay sayfasına geçiş yapar ve hangi kişiye tıklandığını (chat) gönderir.
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetailScreen(chatData: chat)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // AVATAR
            Stack(
              children: [
                CircleAvatar(
                    radius: 28, backgroundImage: NetworkImage(chat.avatarUrl)),
                // Çevrimiçi / Resmi rozeti
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: chat.isOfficial ? Colors.blue : Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: chat.isOfficial
                        ? const Icon(Icons.check, color: Colors.white, size: 8)
                        : null,
                  ),
                )
              ],
            ),
            const SizedBox(width: 15),

            // İSİM VE MESAJ İÇERİĞİ
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(chat.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      if (chat.isOfficial) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text("Yetkili",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(
                        color:
                            chat.unreadCount > 0 ? Colors.black87 : Colors.grey,
                        fontWeight: chat.unreadCount > 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // SAĞ KISIM: ZAMAN VE OKUNMAMIŞ SAYISI
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.time,
                    style:
                        TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                const SizedBox(height: 6),
                if (chat.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: Colors.redAccent, shape: BoxShape.circle),
                    child: Text("${chat.unreadCount}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
