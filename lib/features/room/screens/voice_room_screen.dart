import 'package:flutter/material.dart';
import 'package:runo_live/features/room/widgets/mic_seat.dart';
import 'package:runo_live/features/room/widgets/pk_score_bar.dart';
import 'package:runo_live/features/room/widgets/gift_bottom_sheet.dart';
import 'package:runo_live/features/room/models/gift_model.dart';
import 'package:runo_live/features/room/widgets/gift_animation_player.dart';

class VoiceRoomScreen extends StatefulWidget {
  const VoiceRoomScreen({super.key});

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isPkModeActive = false;
  GiftModel? activeGift;

  void _playGiftAnimation(GiftModel gift) {
    setState(() {
      activeGift = gift;
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
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
                fit: BoxFit.cover),
          ),
          if (isPkModeActive)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withValues(alpha: 0.2),
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.blue.withValues(alpha: 0.2)
                          ],
                        ),
                      ),
                    ),
                  ),
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
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MicSeat(index: 0, userName: "Sahip", isLocked: false),
                    MicSeat(index: 1, userName: "VIP", isLocked: true),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      itemCount: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) =>
                          MicSeat(index: index + 2),
                    ),
                  ),
                ),
                _buildBottomControls(),
              ],
            ),
          ),
          if (activeGift != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: GiftAnimationPlayer(gift: activeGift!),
                  ),
                ),
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
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150')),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("WINNERS AİLESİ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text("Lv.5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8)),
                        ),
                        const SizedBox(width: 5),
                        const Text("ID: 6405397",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 18),
                  const Text(" Top 10",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.power_settings_new,
                        color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("🔥 Odası hediye",
                    style: TextStyle(color: Colors.white, fontSize: 9)),
              )
            ],
          ),
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
          const Icon(Icons.mic_none, color: Colors.white70),
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
