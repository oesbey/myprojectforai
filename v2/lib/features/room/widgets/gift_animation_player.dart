import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:pag/pag.dart';
import 'package:runo_live/features/room/models/gift_model.dart';
import 'package:http/http.dart' as http;

class GiftAnimationPlayer extends StatefulWidget {
  final GiftModel gift;

  const GiftAnimationPlayer({super.key, required this.gift});

  @override
  State<GiftAnimationPlayer> createState() => _GiftAnimationPlayerState();
}

class _GiftAnimationPlayerState extends State<GiftAnimationPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  SVGAAnimationController? _svgaController;
  bool _isSvgaLoaded = false;

  @override
  void initState() {
    super.initState();

    final path = widget.gift.animationPath;
    final isNetwork = path.startsWith('http');

    // WEBM BAŞLATICI
    if (widget.gift.type == AnimationType.webm) {
      if (isNetwork) {
        _videoController = VideoPlayerController.networkUrl(Uri.parse(path));
      } else {
        _videoController = VideoPlayerController.asset(path);
      }
      _videoController!.initialize().then((_) {
        if (mounted) {
          setState(() {});
          _videoController!.play();
        }
      });
    }

    // SVGA BAŞLATICI
    if (widget.gift.type == AnimationType.svga) {
      _svgaController = SVGAAnimationController(vsync: this);
      _loadSvgaSafe(path, isNetwork);
    }
  }

  Future<void> _loadSvgaSafe(String path, bool isNetwork) async {
    try {
      MovieEntity? movie;
      if (isNetwork) {
        final response = await http.get(Uri.parse(path));
        movie = await SVGAParser.shared
            .decodeFromBuffer(response.bodyBytes.toList());
      } else {
        movie = await SVGAParser.shared.decodeFromAssets(path);
      }

      if (mounted && movie != null) {
        _svgaController?.videoItem = movie;
        setState(() {
          _isSvgaLoaded = true;
        });
        _svgaController?.repeat();
      }
    } catch (e) {
      debugPrint("SVGA Yükleme Hatası: $e");
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _svgaController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.gift.animationPath;
    final isNetwork = path.startsWith('http');

    // ELI5: SizedBox.expand = "Ekranın tamamına yayıl!" demektir.

    // 1. PAG MOTORU
    if (widget.gift.type == AnimationType.pag) {
      return SizedBox.expand(
        child: isNetwork ? PAGView.network(path) : PAGView.asset(path),
      );
    }
    // 2. SVGA MOTORU
    else if (widget.gift.type == AnimationType.svga) {
      return _isSvgaLoaded && _svgaController != null
          ? SizedBox.expand(
              // BoxFit.cover -> Boşluk kalmayacak şekilde ekranı kaplar
              child: FittedBox(
                fit: BoxFit.cover,
                child: SVGAImage(_svgaController!),
              ),
            )
          : const SizedBox();
    }
    // 3. LOTTİE MOTORU
    else if (widget.gift.type == AnimationType.lottie) {
      return SizedBox.expand(
        child: isNetwork
            ? Lottie.network(path, fit: BoxFit.cover)
            : Lottie.asset(path, fit: BoxFit.cover),
      );
    }
    // 4. PNG MOTORU
    else if (widget.gift.type == AnimationType.png) {
      return SizedBox.expand(
        child: isNetwork
            ? Image.network(path, fit: BoxFit.cover)
            : Image.asset(path, fit: BoxFit.cover),
      );
    }
    // 5. WEBM MOTORU
    else if (widget.gift.type == AnimationType.webm) {
      if (_videoController != null && _videoController!.value.isInitialized) {
        return SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController!.value.size.width,
              height: _videoController!.value.size.height,
              child: VideoPlayer(_videoController!),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return const SizedBox();
  }
}
