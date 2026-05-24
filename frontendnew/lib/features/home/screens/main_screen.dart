import 'package:flutter/material.dart';
import 'package:runo_live/core/constants/app_colors.dart';
import 'package:runo_live/features/home/screens/home_page.dart';
import 'package:runo_live/features/room/screens/room_list_page.dart';
import 'package:runo_live/features/chat/screens/chat_list_screen.dart';
import 'package:runo_live/features/profile/screens/profile_screen.dart';
// YENİ KEŞFET SAYFASI IMPORTU
import 'package:runo_live/features/discover/screens/discover_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // ELI5: 3. İndex (Pusula/Keşfet) artık yeni DiscoverScreen oldu!
  final List<Widget> _pages = [
    const HomePage(),
    const RoomListPage(),
    const ChatListScreen(),
    const DiscoverScreen(), // YENİ KEŞFET SAYFASI BURADA
    const ProfileScreen(),
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
