import 'package:flutter/material.dart';

// ELI5: Bu bir "Kalıp". Her odanın adı, kaç kişi olduğu ve PK olup olmadığı
// bu kalıba göre belirlenir.
class RoomModel {
  final String title;
  final String subtitle;
  final int memberCount;
  final String category; // PK, Oyun, Sohbet vb.
  final bool isPK;
  final Color? frameColor; // Özel çerçeve rengi (VIP odalar için)
  final String level; // Lv.100 gibi
  final String tag; // Kral, Elmas vb.

  RoomModel({
    required this.title,
    required this.subtitle,
    required this.memberCount,
    required this.category,
    this.isPK = false,
    this.frameColor,
    this.level = "1",
    this.tag = "Üye",
  });
}
