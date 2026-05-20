import 'package:flutter/material.dart';
import 'package:runo_live/features/discover/models/discover_models.dart';

class StoryViewScreen extends StatefulWidget {
  final StoryModel story;

  const StoryViewScreen({super.key, required this.story});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

// SingleTickerProviderStateMixin: Animasyonların (dolma barı) pürüzsüz çalışmasını sağlar
class _StoryViewScreenState extends State<StoryViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentIndex = 0; // O an kaçıncı hikayeye bakıyoruz?

  @override
  void initState() {
    super.initState();
    // ELI5: Her bir hikaye tam 5 saniye sürecek
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _startStory();
  }

  void _startStory() {
    _animationController.reset();
    _animationController.forward();

    // Bar dolduğunda ne olacak?
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });
  }

  void _nextStory() {
    if (_currentIndex < widget.story.imageUrls.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _startStory();
    } else {
      // Hikayeler bittiyse sayfayı kapat
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _startStory();
    }
  }

  // Ekrana tıklanınca sağa mı sola mı basıldığını algılar
  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    // Eğer ekranın sol %30'luk kısmına tıklandıysa geri git, sağa tıklandıysa ileri git
    if (dx < screenWidth * 0.3) {
      _previousStory();
    } else {
      _nextStory();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        onLongPress: () =>
            _animationController.stop(), // Basılı tutunca duraklatır
        onLongPressUp: () =>
            _animationController.forward(), // Bırakınca devam eder
        child: Stack(
          children: [
            // 1. HİKAYE RESMİ
            Positioned.fill(
              child: Image.network(
                widget.story.imageUrls[_currentIndex],
                fit: BoxFit.cover,
              ),
            ),

            // ÜSTTEKİ KARARTMA (Barlar ve isim net okunsun diye)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  // 2. ÜSTTEKİ DOLMA BARLARI (Progress Bars)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: List.generate(
                        widget.story.imageUrls.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return LinearProgressIndicator(
                                  // ELI5: Geçmiş hikayeler 1 (tam dolu), gelecekteki hikayeler 0 (boş), o anki hikaye animasyona bağlı dolar.
                                  value: index < _currentIndex
                                      ? 1.0
                                      : (index == _currentIndex
                                          ? _animationController.value
                                          : 0.0),
                                  backgroundColor: Colors.white38,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                  minHeight: 2.5,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 3. KULLANICI BİLGİSİ
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(widget.story.avatarUrl)),
                        const SizedBox(width: 10),
                        Text(widget.story.userName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(width: 10),
                        const Text("2s",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13)), // 2 saat önce
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 28),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
