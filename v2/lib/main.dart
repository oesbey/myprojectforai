import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';
// Yeni sayfamızı import ettik
import 'package:runo_live/features/auth/screens/login_screen.dart';

void main() {
  runApp(const RunoLiveApp());
}

class RunoLiveApp extends StatelessWidget {
  const RunoLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runo Live',
      debugShowCheckedModeBanner:
          false, // Ekranın köşesindeki 'DEBUG' yazısını kaldırır
      theme: ThemeData(
        brightness: Brightness.light, // Şimdilik aydınlık tema yapıyoruz
        scaffoldBackgroundColor: AppColors.backgroundLight,
        primaryColor: AppColors.primaryBrand,
      ),
      // Uygulama artık LoginScreen ile açılacak!
      home: const LoginScreen(),
    );
  }
}
