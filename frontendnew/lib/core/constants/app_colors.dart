import 'package:flutter/material.dart';

// ELI5: Boya kutumuz. Gönderdiğin resimdeki renkleri buraya "Hex" kodlarıyla ekledim.
class AppColors {
  // Eski karanlık tema renklerimiz (İleride gece modu için lazım olacak)
  static const Color backgroundDark = Color(0xFF121212);

  // Yeni: Runo Live Giriş Ekranı Renkleri
  static const Color backgroundLight = Color(0xFFFFFFFF); // Alt kısımdaki beyaz
  static const Color topGradientLight =
      Color(0xFFD4FCFB); // Üstteki açık turkuaz

  static const Color textPrimary = Color(0xFF1E1E1E); // Siyahımsı koyu gri yazı
  static const Color textSecondary =
      Color(0xFF9E9E9E); // "veya" yazısı gibi gri metinler

  static const Color buttonBackground =
      Color(0xFFF5F5F5); // Google butonunun açık gri arkası
  static const Color primaryBrand =
      Color(0xFF00E5FF); // Logo ve ana butonlar için turkuaz

  static const Color warningYellow =
      Color(0xFFFFD54F); // "Son giriş" etiketi sarısı
}
