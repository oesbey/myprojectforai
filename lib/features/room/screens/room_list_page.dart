import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';
import 'package:runo_live/features/room/models/room_model.dart';
// ELI5: Burası çok önemli! Tıklayınca açılacak sayfanın adresini buraya ekledik.
import 'package:runo_live/features/room/screens/voice_room_screen.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  String selectedCategory = 'Önerilen';

  final List<RoomModel> allRooms = [
    RoomModel(
        title: "👑 BİTİRİM İKİLİ 👑",
        subtitle: "Herkes Hak Ettiğini Yaşar...",
        memberCount: 24,
        category: "Sohbet",
        isPK: true,
        frameColor: Colors.amber,
        level: "31",
        tag: "Kral"),
    RoomModel(
        title: "🦅 KARTAL 🦅",
        subtitle: "Resmi Jeton Bayiliği",
        memberCount: 74,
        category: "PK",
        isPK: true,
        frameColor: Colors.purple,
        level: "106",
        tag: "Elmas"),
    RoomModel(
        title: "✨ AY IŞIĞI ✨",
        subtitle: "Bingo, Sohbet, Müzik",
        memberCount: 58,
        category: "Oyun",
        isPK: false,
        level: "90",
        tag: "Gümüş"),
    RoomModel(
        title: "❤️ DOSTLuK ❤️",
        subtitle: "Jeton Bayimiz Mevcuttur",
        memberCount: 49,
        category: "Sohbet",
        isPK: true,
        frameColor: Colors.red,
        level: "108",
        tag: "Kral"),
    RoomModel(
        title: "🎥 Video Odası 01",
        subtitle: "Film İzliyoruz",
        memberCount: 12,
        category: "Video",
        isPK: false,
        level: "20",
        tag: "Üye"),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRooms = selectedCategory == 'Önerilen'
        ? allRooms
        : (selectedCategory == 'PK'
            ? allRooms.where((r) => r.isPK).toList()
            : allRooms.where((r) => r.category == selectedCategory).toList());

    return Column(
      children: [
        _buildTopBar(),
        _buildCategoryTabs(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: filteredRooms.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // ELI5: _RoomCard'ı burada çağırırken ona tıklandığında ne yapacağını söylüyoruz.
              return _RoomCard(room: filteredRooms[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Text("Keşfet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Text("İstanbul",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          const Spacer(),
          const Icon(Icons.search, size: 28),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final tabs = ['Önerilen', 'PK', 'Oyun', 'Sohbet', 'Video'];
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == tabs[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = tabs[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryBrand : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final RoomModel room;
  const _RoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    // ELI5: GestureDetector, ekrandaki dokunmaları (tık) anlayan gizli bir sensördür.
    return GestureDetector(
      onTap: () {
        // Navigator.push: "Beni yeni bir sayfaya götür" demektir.
        // Yeni sayfayı (VoiceRoomScreen) bir kart gibi eski sayfanın üstüne koyar.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VoiceRoomScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: room.frameColor?.withOpacity(0.5) ?? Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (room.frameColor ?? Colors.black).withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildRoomImage(),
            const SizedBox(width: 12),
            Expanded(child: _buildRoomInfo()),
            _buildRoomStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomImage() {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade300,
          ),
          child: const Icon(Icons.room, color: Colors.white),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Text("🇹🇷", style: TextStyle(fontSize: 10)),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          room.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          room.subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildBadge(room.tag, Colors.blue),
            const SizedBox(width: 4),
            _buildBadge("Lv.${room.level}", Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRoomStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (room.isPK)
          Image.asset('assets/images/pk_icon.png', width: 35, height: 35)
        else
          const Icon(Icons.bar_chart, color: AppColors.primaryBrand),
        Text(
          "${room.memberCount}",
          style: const TextStyle(
              color: AppColors.primaryBrand,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ],
    );
  }
}
