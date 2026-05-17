import 'package:flutter/material.dart';

class PkScoreBar extends StatelessWidget {
  const PkScoreBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(color: const Color(0xFFFF0055)), // Kırmızı taraf
            ),
            Container(width: 2, color: Colors.white), // Orta parlama
            Expanded(
              flex: 5,
              child: Container(color: const Color(0xFF0099FF)), // Mavi taraf
            ),
          ],
        ),
      ),
    );
  }
}
