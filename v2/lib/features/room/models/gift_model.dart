// ELI5: Hediyemizin türünü belirleyen etiketler. Artık PAG da var!
enum AnimationType { svga, lottie, webm, png, pag }

class GiftModel {
  final String id;
  final String name;
  final int price;
  final String iconUrl;
  final String animationPath;
  final AnimationType type;

  GiftModel({
    required this.id,
    required this.name,
    required this.price,
    required this.iconUrl,
    required this.animationPath,
    required this.type,
  });
}
