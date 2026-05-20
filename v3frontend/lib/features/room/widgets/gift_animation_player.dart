import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:pag/pag.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:runo_live/features/room/models/gift_model.dart';
// ELI5: SVGA tamamen silindi!

class GiftAnimationPlayer extends StatefulWidget {
  final GiftModel gift;
  const GiftAnimationPlayer({super.key, required this.gift});

  @override
  State<GiftAnimationPlayer> createState() => _GiftAnimationPlayerState();
}

class _GiftAnimationPlayerState extends State<GiftAnimationPlayer> {
  VideoPlayerController? _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();

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
          _playAudio();
        }
      });
    } else {
      _playAudio(); // Lottie, PAG veya PNG ise direkt sesi çal
    }
  }

  void _playAudio() {
    if (widget.gift.audioPath != null) {
      if (widget.gift.audioPath!.startsWith('http')) {
        _audioPlayer.play(UrlSource(widget.gift.audioPath!));
      } else {
        _audioPlayer.play(AssetSource(widget.gift.audioPath!));
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.gift.animationPath;
    final isNetwork = path.startsWith('http');

    if (widget.gift.type == AnimationType.pag) {
      return SizedBox.expand(
          child: isNetwork ? PAGView.network(path) : PAGView.asset(path));
    } else if (widget.gift.type == AnimationType.lottie) {
      return SizedBox.expand(
          child: isNetwork
              ? Lottie.network(path, fit: BoxFit.cover)
              : Lottie.asset(path, fit: BoxFit.cover));
    } else if (widget.gift.type == AnimationType.png) {
      return SizedBox.expand(
          child: isNetwork
              ? Image.network(path, fit: BoxFit.cover)
              : Image.asset(path, fit: BoxFit.cover));
    } else if (widget.gift.type == AnimationType.webm) {
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
      }
    }
    return const SizedBox();
  }
}
