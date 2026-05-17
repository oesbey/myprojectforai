import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';

// ELI5: Bu bizim özel buton fabrikamız.
// Dışarıdan ikon, yazı ve tıklanma özelliği alıp bize standart bir buton veriyor.
class SocialLoginButton extends StatelessWidget {
  final String text; // Butonun üstündeki yazı
  final IconData icon; // Butonun ikonu
  final Color iconColor; // İkonun rengi
  final VoidCallback onPressed; // Tıklanınca ne olacağı
  final bool isLastLogin; // "Son giriş" etiketi görünsün mü?

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    this.isLastLogin = false, // Varsayılan olarak etiket yok
  });

  @override
  Widget build(BuildContext context) {
    // Stack: Elemanları üst üste koymamızı sağlar.
    // Butonun "üstüne" son giriş etiketini koymak için kullanıyoruz.
    return Stack(
      clipBehavior: Clip.none, // Etiket butonun dışına taşabilsin diye
      children: [
        // Asıl butonumuz
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30), // Kenarları yuvarlak
          child: Container(
            width: double.infinity, // Ekranı yanlamasına kapla
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.buttonBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 12), // İkon ile yazı arasına boşluk
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Eğer bu en son girilen yöntemse sarı etiketi göster
        if (isLastLogin)
          Positioned(
            right: 20, // Sağdan 20 birim içeride
            top: -12, // Yukarıya doğru 12 birim taşmış
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warningYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Son giriş',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
