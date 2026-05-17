import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:runo_live/features/room/models/gift_model.dart';

class GiftAnimationPlayer extends StatefulWidget {
  final GiftModel gift;

  const GiftAnimationPlayer({super.key, required this.gift});

  @override
  State<GiftAnimationPlayer> createState() => _GiftAnimationPlayerState();
}

class _GiftAnimationPlayerState extends State<GiftAnimationPlayer> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.gift.type == AnimationType.webm) {
      _videoController = VideoPlayerController.asset(widget.gift.animationPath)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            _videoController!.play();
          }
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gift.type == AnimationType.svga) {
      return SVGASimpleImage(
        assetsName: widget.gift.animationPath,
      );
    } else if (widget.gift.type == AnimationType.lottie) {
      return Lottie.asset(
        widget.gift.animationPath,
        fit: BoxFit.contain,
      );
    } else if (widget.gift.type == AnimationType.png) {
      return Image.asset(
        widget.gift.animationPath,
        fit: BoxFit.contain,
      );
    } else if (widget.gift.type == AnimationType.webm) {
      if (_videoController != null && _videoController!.value.isInitialized) {
        return SizedBox(
          width: _videoController!.value.size.width,
          height: _videoController!.value.size.height,
          child: VideoPlayer(_videoController!),
        );
      } else {
        return const SizedBox();
      }
    }
    return const SizedBox();
  }
}
