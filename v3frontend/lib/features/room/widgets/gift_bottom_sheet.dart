import 'package:flutter/material.dart';
import 'package:runo_live/features/room/models/gift_model.dart';

class GiftBottomSheet extends StatelessWidget {
  final Function(GiftModel) onGiftSelected;

  const GiftBottomSheet({super.key, required this.onGiftSelected});

  List<GiftModel> get gifts => [
        GiftModel(
            id: "1",
            name: "PAG Şöleni",
            price: 5000,
            iconUrl:
                "https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/png/payton.png",
            // ELI5: Çinli devi PAG'ın test dosyası
            animationPath:
                "assets/animations/pag/test.pag", // Şimdilik boş bir yol
            audioPath:
                "https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/mp3/sari_ask.mp3",
            type: AnimationType.pag),
        GiftModel(
            id: "2",
            name: "WebM Işık",
            price: 10000,
            iconUrl:
                "https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/png/roket.png",
            animationPath:
                "assets/animations/webm/light.webm", // Şimdilik boş bir yol
            audioPath:
                "https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/mp3/roket.mp3",
            type: AnimationType.webm),
        GiftModel(
            id: "3",
            name: "Lottie Gül",
            price: 3500,
            iconUrl:
                "https://raw.githubusercontent.com/oesbey/myprojectforai/main/v2/assets/animations/png/ask_balonu.png",
            animationPath:
                "https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/LottieLogo1.json",
            type: AnimationType.lottie),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const Text("Hediye Gönder",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: gifts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
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
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          gift.iconUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.card_giftcard,
                                  color: Colors.white24),
                        ),
                        const SizedBox(height: 8),
                        Text(gift.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                            textAlign: TextAlign.center,
                            maxLines: 1),
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
