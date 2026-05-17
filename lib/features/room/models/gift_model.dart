// ELI5: Hediyemizin türünü belirleyen etiketler.
enum AnimationType { svga, lottie, webm, png }

class GiftModel {
  final String id;
  final String name;
  final int price;
  final String iconUrl;
  final String animationPath; // Dosyanın nerede olduğu
  final AnimationType type; // Dosyanın türü (svga, lottie vb.)

  GiftModel({
    required this.id,
    required this.name,
    required this.price,
    required this.iconUrl,
    required this.animationPath,
    required this.type,
  });
}
