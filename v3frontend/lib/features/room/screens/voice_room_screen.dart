import 'dart:math';
import 'package:flutter/material.dart';
import 'package:runo_live/features/room/widgets/mic_seat.dart';
import 'package:runo_live/features/room/widgets/pk_score_bar.dart';
import 'package:runo_live/features/room/widgets/gift_bottom_sheet.dart';
import 'package:runo_live/features/room/models/gift_model.dart';
import 'package:runo_live/features/room/widgets/gift_animation_player.dart';
import 'package:runo_live/features/room/widgets/room_chat_list.dart';
import 'package:runo_live/core/network/livekit_service.dart';

class VoiceRoomScreen extends StatefulWidget {
  const VoiceRoomScreen({super.key});

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isPkModeActive = false;
  GiftModel? activeGift;

  final LiveKitService _liveKitService = LiveKitService();
  bool isConnected = false;
  bool isMicOn = false;

  String myRandomName = "Bağlanıyor...";

  @override
  void initState() {
    super.initState();
    _initVoiceRoom();
  }

  Future<void> _initVoiceRoom() async {
    try {
      // ELI5: SENİN ALDIĞIN GERÇEK BİLETLER (HAVUZ)
      List<String> biletHavuzu = [
        "eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiVGVzdFVzZXJfMSIsInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJyb29tIjoiTHVtbXktMSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSVZyckVSV2lrZXJ2UCIsImV4cCI6MTc3OTI0NTU4NSwibmJmIjoxNzc5MjIzOTg1LCJzdWIiOiJUZXN0VXNlcl8xIn0.9fzhXi_y2xuvWMIbSf-ZTyg0HydjXuoHWxYsNt1EkTk",
        "eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiVGVzdFVzZXJfMiIsInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJyb29tIjoiTHVtbXktMSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSVZyckVSV2lrZXJ2UCIsImV4cCI6MTc3OTI0NTYwOSwibmJmIjoxNzc5MjI0MDA5LCJzdWIiOiJUZXN0VXNlcl8yIn0.w7gxF99BgtxzMqtyZsiAHzwtYzxE9EOdOQhnCeC0muw",
        "eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiVGVzdFVzZXJfMyIsInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJyb29tIjoiTHVtbXktMSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSVZyckVSV2lrZXJ2UCIsImV4cCI6MTc3OTI0NTYyOSwibmJmIjoxNzc5MjI0MDI5LCJzdWIiOiJUZXN0VXNlcl8zIn0.bwUuhIJuUlFYfMm8CYz9jQoAFFGtfVmbY1pbjXJiy04",
      ];

      // Odaya giren cihaza rastgele bir bilet veriyoruz
      int rastgeleIndex = Random().nextInt(biletHavuzu.length);
      String secilenBilet = biletHavuzu[rastgeleIndex];

      // Ekranda adımızı göstermek için
      setState(() {
        myRandomName = "TestUser_${rastgeleIndex + 1}";
      });

      // Biletle Almanya'daki ses sunucusuna bağlanıyoruz!
      bool success = await _liveKitService.connect(
          'wss://live.lummylive.com', secilenBilet);

      if (mounted) {
        setState(() {
          isConnected = success;
        });
      }
    } catch (e) {
      debugPrint("Sunucuya bağlanılamadı: $e");
    }
  }

  @override
  void dispose() {
    _liveKitService.disconnect();
    super.dispose();
  }

  void _playGiftAnimation(GiftModel gift) {
    setState(() {
      activeGift = gift;
    });
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && activeGift == gift) {
        setState(() {
          activeGift = null;
        });
      }
    });
  }

  void _showGiftPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GiftBottomSheet(
        onGiftSelected: (gift) => _playGiftAnimation(gift),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0B21),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/oda_arkaplan.png',
                  fit: BoxFit.cover)),
          if (isPkModeActive)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                    Colors.red.withValues(alpha: 0.2),
                    Colors.transparent
                  ])))),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.blue.withValues(alpha: 0.2)
                  ])))),
                ],
              ),
            )
          else
            Positioned.fill(child: Container(color: Colors.black45)),
          SafeArea(
            child: Column(
              children: [
                _buildRichHeader(context),
                if (isPkModeActive) const PkScoreBar(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Koltukta aldığımız rastgele ismi gösteriyoruz
                    MicSeat(
                        index: 0,
                        userName: myRandomName,
                        isLocked: false,
                        size: 75),
                    const MicSeat(
                        index: 1, userName: "VIP", isLocked: true, size: 75),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.80,
                    ),
                    itemBuilder: (context, index) =>
                        MicSeat(index: index + 2, size: 55),
                  ),
                ),
                const SizedBox(height: 10),
                const Expanded(child: RoomChatList()),
                _buildBottomControls(),
              ],
            ),
          ),
          if (activeGift != null)
            Positioned.fill(
              child: IgnorePointer(
                child: GiftAnimationPlayer(gift: activeGift!),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRichHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon:
                  const Icon(Icons.chevron_left, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context)),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.group, color: Colors.white, size: 18)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("LUMMY AİLESİ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: isConnected ? Colors.green : Colors.red,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 5),
                        Text(isConnected ? "Bağlı" : "Bağlanıyor...",
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              icon: const Icon(Icons.power_settings_new, color: Colors.white70),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      color: Colors.black26,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (isConnected) {
                setState(() => isMicOn = !isMicOn);
                await _liveKitService.toggleMic(isMicOn);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isMicOn ? Colors.green : Colors.white10),
              child: Icon(isMicOn ? Icons.mic : Icons.mic_off,
                  color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.sentiment_satisfied_alt, color: Colors.white70),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text("Bir şeyler söyle...",
                      style: TextStyle(color: Colors.white38, fontSize: 13))),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => isPkModeActive = !isPkModeActive),
            child: Icon(Icons.grid_view_rounded,
                color: isPkModeActive ? Colors.cyan : Colors.white70),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _showGiftPanel,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pinkAccent),
              child: const Icon(Icons.card_giftcard,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
