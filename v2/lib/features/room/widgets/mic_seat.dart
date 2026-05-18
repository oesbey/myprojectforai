import 'package:flutter/material.dart';

class MicSeat extends StatelessWidget {
  final int index;
  final String? userName;
  final bool isLocked;
  final double size;

  const MicSeat({
    super.key,
    required this.index,
    this.userName,
    this.isLocked = false,
    this.size = 55.0, // Alt 8'li koltukların varsayılan boyutu
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- YUMUŞATILMIŞ KOLTUK DAİRESİ ---
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // 1. Arka planı daha yumuşak bir beyaz saydamlığı yaptık
            color: Colors.white.withValues(alpha: 0.10),
            // 2. Kenarlığın keskinliğini aldık (Çok ince ve çok saydam)
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
            // 3. Koltuğun arkasına karanlık bir gölge ekledik, böylece arka plandan şık bir şekilde ayrılır
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: Icon(
            isLocked ? Icons.lock_outline : Icons.add,
            color: Colors.white.withValues(
                alpha: 0.6), // İkon da artık çok keskin (cırtlak) beyaz değil
            size: size * 0.35, // İkon koltuğa göre orantılı büyür/küçülür
          ),
        ),

        const SizedBox(height: 6),

        // --- KULLANICI ADI VEYA NUMARA ---
        Text(
          userName ?? "${index + 1}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
