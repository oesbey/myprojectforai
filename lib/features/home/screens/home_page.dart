import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FDFF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BURASI CONST YAPILDI
                const _TopHeaderNavigation(),
                const SizedBox(height: 24),
                const Text(
                  'Oyunlar',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.5),
                ),
                const SizedBox(height: 16),
                _buildGameCard('assets/images/mikrofon.png', ratio: 2.5),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildGameCard('assets/images/ludo.png', ratio: 1)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildGameCard('assets/images/jackaroo.png',
                            ratio: 1)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: _buildGameCard('assets/images/domino.png',
                            ratio: 1)),
                    const SizedBox(width: 12),
                    Expanded(
                        child:
                            _buildGameCard('assets/images/uno.png', ratio: 1)),
                  ],
                ),
                const SizedBox(height: 36),
                const Text('Keşfet',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A))),
                const SizedBox(height: 16),
                _buildDiscoverItem('Katran Nrv', 'Herkes Hak Ettiği...', true),
                _buildDiscoverItem('Sena', 'Çünkü vefasızlık...', true),
                _buildDiscoverItem('Asel', 'O çok gizemli', false),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(String imagePath, {required double ratio}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          // OPACITY DÜZELTİLDİ
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: AspectRatio(
          aspectRatio: ratio,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverItem(String name, String description, bool isVoiceRoom) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFFEEEEEE),
            child: Icon(Icons.person, color: Colors.grey, size: 35),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(description,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    maxLines: 1),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.bar_chart_rounded,
                  color: isVoiceRoom
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF2196F3),
                  size: 20),
              const SizedBox(width: 4),
              Text(
                isVoiceRoom ? 'Sohbet Odası oynuyor' : 'Video Odası oynuyor',
                style: TextStyle(
                    color: isVoiceRoom
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF2196F3),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TopHeaderNavigation extends StatelessWidget {
  const _TopHeaderNavigation();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D1),
                  borderRadius: BorderRadius.circular(20)),
              child: const Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.orange, size: 18),
                  SizedBox(width: 4),
                  Text("53 +",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.brown)),
                ],
              ),
            ),
            const Spacer(),
            const Column(
              children: [
                Icon(Icons.stars_rounded, color: Color(0xFF00BCD4), size: 30),
                Text("Etkinlik",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavCircle(Icons.emoji_events, "Sıralama", Colors.purple),
            _buildNavCircle(Icons.assignment_turned_in, "Görev", Colors.blue),
            _buildNavCircle(Icons.people, "Çevrimiçi", Colors.teal),
          ],
        ),
      ],
    );
  }

  Widget _buildNavCircle(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // OPACITY DÜZELTİLDİ
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        const Text("Etiket",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF555555))),
      ],
    );
  }
}
