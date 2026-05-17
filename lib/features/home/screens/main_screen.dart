import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';
import 'package:runo_live/features/home/screens/home_page.dart';
import 'package:runo_live/features/room/screens/room_list_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const RoomListPage(),
    const Center(child: Text("Mesaj Sayfası (Yakında)")),
    const Center(child: Text("Keşfet Sayfası (Yakında)")),
    const Center(child: Text("Profil Sayfası (Yakında)")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryBrand,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset_outlined), label: 'Oyunlar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mic_none_rounded), label: 'Sohbet Odası'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'Mesaj'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined), label: 'Keşfet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Benim'),
          ],
        ),
      ),
    );
  }
}
