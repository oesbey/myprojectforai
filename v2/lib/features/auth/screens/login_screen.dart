import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';
import 'package:runo_live/shared/widgets/social_login_button.dart';
import 'package:runo_live/features/home/screens/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAppleDevice =
        Theme.of(context).platform == TargetPlatform.iOS ||
            Theme.of(context).platform == TargetPlatform.macOS;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.topGradientLight,
              AppColors.backgroundLight,
              AppColors.backgroundLight,
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mail_outline,
                        size: 16, color: AppColors.primaryBrand),
                    label: const Text('Yardıma ihtiyacınız var mı?',
                        style: TextStyle(color: AppColors.primaryBrand)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBrand),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported,
                        size: 80, color: Colors.grey);
                  },
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SocialLoginButton(
                      text: 'Google ile oturum aç',
                      icon: Icons.g_mobiledata,
                      iconColor: Colors.red,
                      isLastLogin: true,
                      onPressed: () {},
                    ),
                    if (isAppleDevice) ...[
                      const SizedBox(height: 16),
                      SocialLoginButton(
                        text: 'Apple ile oturum aç',
                        icon: Icons.apple,
                        iconColor: Colors.black,
                        onPressed: () {},
                      ),
                    ],
                    const SizedBox(height: 24),

                    // CONST HATASI BURADAN GİDERİLDİ
                    const Row(
                      children: [
                        Expanded(
                            child: Divider(
                                color: AppColors.textSecondary,
                                thickness: 0.5)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('veya',
                              style: TextStyle(color: AppColors.textSecondary)),
                        ),
                        Expanded(
                            child: Divider(
                                color: AppColors.textSecondary,
                                thickness: 0.5)),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircleIcon(Icons.facebook, Colors.blue),
                        _buildCircleIcon(Icons.phone_android, Colors.green),
                        _buildCircleIcon(
                            Icons.person_outline, AppColors.primaryBrand),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Devam ederek Hizmet Şartlarını ve Gizlilik Politikasını kabul etmiş olursunuz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                        );
                      },
                      child: const Text(
                        'Test Girişi Yap (Geliştirici)',
                        style: TextStyle(
                            color: AppColors.primaryBrand,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: AppColors.buttonBackground, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
