import 'package:flutter/material.dart';

class MicSeat extends StatelessWidget {
  final int index;
  final String? userName;
  final bool isLocked;

  const MicSeat({
    super.key,
    required this.index,
    this.userName,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // withOpacity yerine withValues kullanıldı
            color: Colors.black.withValues(alpha: 0.3),
            border: Border.all(color: Colors.white10, width: 1),
          ),
          child: Icon(
            isLocked ? Icons.lock_outline : Icons.add,
            color: Colors.white24,
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          userName ?? "${index + 1}",
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
      ],
    );
  }
}
