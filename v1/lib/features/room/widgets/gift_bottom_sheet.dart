import 'package:flutter/material.dart';
import 'package:runo_live/features/room/models/gift_model.dart';

class GiftBottomSheet extends StatelessWidget {
  final Function(GiftModel) onGiftSelected;

  GiftBottomSheet({super.key, required this.onGiftSelected});

  // ELI5: ÇOKLU FORMAT DESTEKLİ TEST LİSTESİ!
  // İlk sıraya senin "payton.svga" dosyanı koyduk.
  final List<GiftModel> gifts = [
    GiftModel(
        id: "1",
        name: "Payton",
        price: 5000,
        iconUrl: "🐎",
        animationPath: "assets/animations/svga/payton.svga",
        type: AnimationType.svga),
    // Alttakiler test amaçlı dolduruldu (Klasörlerde bu dosyalar olmasa bile şablon hazır)
    GiftModel(
        id: "2",
        name: "Lottie Gül",
        price: 10,
        iconUrl: "🌹",
        animationPath: "assets/animations/lottie/rose.json",
        type: AnimationType.lottie),
    GiftModel(
        id: "3",
        name: "WebM Işık",
        price: 99,
        iconUrl: "✨",
        animationPath: "assets/animations/webm/light.webm",
        type: AnimationType.webm),
    GiftModel(
        id: "4",
        name: "PNG Çerçeve",
        price: 50,
        iconUrl: "🖼️",
        animationPath: "assets/animations/png/frame.png",
        type: AnimationType.png),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Text("Hediye Gönder",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: gifts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final gift = gifts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onGiftSelected(gift);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gift.iconUrl,
                            style: const TextStyle(fontSize: 30)),
                        const SizedBox(height: 5),
                        Text(gift.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.generating_tokens,
                                color: Colors.orange, size: 10),
                            const SizedBox(width: 2),
                            Text("${gift.price}",
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
