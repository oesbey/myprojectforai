// SVGA silindi!
enum AnimationType { lottie, webm, png, pag }

class GiftModel {
  final String id;
  final String name;
  final int price;
  final String iconUrl;
  final String animationPath;
  final String? audioPath;
  final AnimationType type;

  GiftModel({
    required this.id,
    required this.name,
    required this.price,
    required this.iconUrl,
    required this.animationPath,
    this.audioPath,
    required this.type,
  });
}
