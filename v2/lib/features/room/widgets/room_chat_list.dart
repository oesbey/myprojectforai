import 'package:flutter/material.dart';

// ELI5: Burası odanın sol alt köşesinde sürekli akan mesaj listemiz.
class RoomChatList extends StatelessWidget {
  const RoomChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // ELI5: ListView aşağıdan yukarıya doğru kaymasını sağlar
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildSystemMessage(
              "🔔 Sistem: Runo Live'a hoş geldiniz. Küfür, hakaret ve kural ihlali yasaktır. İyi eğlenceler!"),
          _buildUserMessage(
              "Lv.5", "Katran Nrv", "Selam odadakiler! Nasılsınız?"),
          _buildUserMessage("Lv.2", "Asel", "Selam Katran, hoş geldin."),
          _buildGiftMessage("Lv.10", "Luke Hobbs", "Payton gönderdi! 🐎"),
          _buildUserMessage("Lv.7", "Sena", "Hadi PK başlatalım!"),
        ],
      ),
    );
  }

  // --- 1. SİSTEM MESAJI TASARIMI ---
  Widget _buildSystemMessage(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child:
          Text(text, style: const TextStyle(color: Colors.amber, fontSize: 12)),
    );
  }

  // --- 2. NORMAL KULLANICI MESAJI TASARIMI ---
  Widget _buildUserMessage(String level, String name, String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      // RichText: Farklı renkleri aynı satırda yazabilmemizi sağlar
      child: RichText(
        text: TextSpan(
          children: [
            // Seviye Rozeti
            WidgetSpan(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(level,
                    style: const TextStyle(color: Colors.white, fontSize: 9)),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
            // Kullanıcı Adı
            TextSpan(
                text: "$name: ",
                style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            // Mesajın Kendisi
            TextSpan(
                text: message,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  // --- 3. HEDİYE MESAJI TASARIMI (Gradyanlı) ---
  Widget _buildGiftMessage(String level, String name, String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // Hediye atıldığı için arka planı hafif pembe/kırmızı parlar
        gradient: LinearGradient(colors: [
          Colors.pinkAccent.withValues(alpha: 0.3),
          Colors.transparent
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(level,
                    style: const TextStyle(color: Colors.white, fontSize: 9)),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
            TextSpan(
                text: "$name ",
                style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            TextSpan(
                text: message,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
