import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:runo_live/core/constants/app_colors.dart';
import 'package:runo_live/features/home/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginMode = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    setState(() => isLoading = true);

    // ELI5: KÖPRÜLER YIKILDI! Doğrudan kendi Almanya sunucumuza gidiyoruz!
    final String targetUrl = isLoginMode
        ? 'http://185.185.83.153:3000/api/auth/login'
        : 'http://185.185.83.153:3000/api/auth/register';

    try {
      final response = await http.post(
        Uri.parse(targetUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (data['basari'] == true) {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['mesaj']), backgroundColor: Colors.red));
        }
      }
    } catch (e) {
      if (mounted) {
        // Artık mobil cihazda çalışacağımız için bu hata bloğuna normal şartlarda hiç düşmeyeceğiz.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Sunucu Bağlantı Hatası: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4)));
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.topGradientLight,
              AppColors.backgroundLight,
              AppColors.backgroundLight
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.primaryBrand,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(Icons.gamepad,
                          size: 60, color: Colors.white),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Text(isLoginMode ? 'Giriş Yap' : 'Kayıt Ol',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adı",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBrand,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: isLoading ? null : _submitForm,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(isLoginMode ? 'Giriş Yap' : 'Kayıt Ol',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => setState(() {
                    isLoginMode = !isLoginMode;
                    _usernameController.clear();
                    _passwordController.clear();
                  }),
                  child: Text(
                      isLoginMode
                          ? "Hesabın yok mu? Kayıt Ol"
                          : "Zaten hesabın var mı? Giriş Yap",
                      style: const TextStyle(color: Colors.black54)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
