import 'package:flutter/material.dart';

// ELI5: Burası kullanıcının şov yaptığı Profil Ekranı.
// Her bir bölümü (Hediye Duvarı, Birlik, Yakın Arkadaşlar) aşağıda küçük parçalara böldük ki kod çorbaya dönmesin.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomActions(),

      // ELI5: İçerik ekranın en üstünden (saat ve şarjın altından) başlasın diye padding'i sıfırlıyoruz.
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // --- ÜST KISIM: KAPAK FOTOĞRAFI VE KULLANICI BİLGİLERİ ---
              _buildCoverAndHeader(context),

              // --- ALT KISIM: DETAYLI BÖLÜMLER ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // KEŞFET BÖLÜMÜ
                    _buildSectionTitle("Keşfet", trailingText: "7"),
                    _buildDiscoverSection(),

                    const SizedBox(height: 20),

                    // HEDİYE DUVARI BÖLÜMÜ
                    _buildSectionTitle("Hediye Duvarı"),
                    _buildGiftWall(),

                    const SizedBox(height: 20),

                    // ŞAHSİ İMZA BÖLÜMÜ
                    _buildSectionTitle("Şahsi İmza"),
                    const Text("💛💙 Hayat yaşamaya değer...",
                        style: TextStyle(color: Colors.black87, fontSize: 13)),

                    const SizedBox(height: 20),

                    // YAKIN ARKADAŞ BÖLÜMÜ
                    _buildSectionTitle("Yakın arkadaş", trailingText: "❤️ 10"),
                    _buildCloseFriends(),

                    const SizedBox(height: 20),

                    // KORUMA (GUARDIANS) BÖLÜMÜ
                    _buildSectionTitle("Koruma"),
                    _buildGuardians(),

                    const SizedBox(height: 20),

                    // BİRLİK BÖLÜMÜ
                    _buildSectionTitle("Birlik"),
                    _buildBirlikCard(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =======================================================================
  // ALT PARÇALAR (MODÜLER YAPI İÇİN BÖLÜNMÜŞ WIDGET'LAR)
  // =======================================================================

  Widget _buildCoverAndHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 350,
          width: double.infinity,
          child: Image.network(
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=800&auto=format&fit=crop',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.grey.shade300),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () {},
              ),
              IconButton(
                icon:
                    const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 320),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text("✨ KiRAZ 🕊️",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black)),
                  SizedBox(width: 8),
                  Icon(Icons.edit_note, color: Colors.grey, size: 18),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildTag(Icons.female, "Lv.246", Colors.pinkAccent),
                  const SizedBox(width: 6),
                  _buildTag(Icons.monetization_on, "911672", Colors.orange),
                  const Spacer(),
                  const Text("🇹🇷 Türkiye",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("ID: 19127426",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.copy, color: Colors.grey.shade400, size: 14),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildMedal("assets/images/medal1.png", Colors.amber),
                  const SizedBox(width: 8),
                  _buildMedal("assets/images/medal2.png", Colors.orange),
                  const SizedBox(width: 8),
                  _buildMedal("assets/images/medal3.png", Colors.brown),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverSection() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/150'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGiftWall() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B1E4A), Color(0xFF1F0D29)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
                color: Colors.white24, borderRadius: BorderRadius.circular(12)),
            child:
                const Icon(Icons.card_giftcard, color: Colors.white, size: 30),
          ),
          // ELI5: HATA BURADAYDI! Buradaki CONST kelimesini sildik ve hatayı yok ettik.
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("436",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text("Hediye",
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                Container(width: 1, height: 40, color: Colors.white24),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("603",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text("Yıldız",
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseFriends() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildFriendCard("LV4", Colors.blue.shade200, Colors.blue.shade400,
              Icons.flight_takeoff),
          _buildFriendCard("LV3", Colors.cyan.shade200, Colors.cyan.shade400,
              Icons.airplanemode_active),
          _buildFriendCard(
              "LV3", Colors.pink.shade200, Colors.pink.shade400, Icons.flight),
        ],
      ),
    );
  }

  Widget _buildGuardians() {
    return Row(
      children: List.generate(
          4,
          (index) => Align(
                widthFactor: 0.7,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=${index + 10}'),
                  ),
                ),
              )),
    );
  }

  Widget _buildBirlikCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black87),
            child: const Icon(Icons.shield, color: Colors.amber),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("PRESTİJJ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text("Lider yardımcısı",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(4)),
                child: const Row(
                  children: [
                    Icon(Icons.shield, color: Colors.white, size: 10),
                    SizedBox(width: 4),
                    Text("4",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFF5285), Color(0xFFFF7A9F)]),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text("Hediye Et",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF00B4DB), Color(0xFF0083B0)]),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_rounded,
                        color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text("Mesaj gönder",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String? trailingText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              if (trailingText != null) ...[
                const SizedBox(width: 6),
                Text(trailingText,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ]
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildTag(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 12),
          const SizedBox(width: 2),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMedal(String assetPath, Color fallbackColor) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: fallbackColor.withValues(alpha: 0.2)),
      child: Icon(Icons.military_tech, color: fallbackColor, size: 20),
    );
  }

  Widget _buildFriendCard(
      String level, Color colorStart, Color colorEnd, IconData icon) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [colorStart, colorEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.5), size: 40),
          Positioned(
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(level,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const Positioned(
            bottom: 12,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 14,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=5')),
            ),
          ),
        ],
      ),
    );
  }
}
