import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

// ELI5: Flutter ile Ses Sunucumuz (LiveKit) arasında tercümanlık yapan dosya.
class LiveKitService {
  late Room room;

  LiveKitService() {
    room = Room();
  }

  // 1. Odaya Bağlanma
  Future<bool> connect(String url, String token) async {
    try {
      await room.connect(url, token);
      debugPrint('✅ LiveKit Sunucusuna Başarıyla Bağlanıldı!');
      return true;
    } catch (e) {
      debugPrint('❌ LiveKit Bağlantı Hatası: $e');
      return false;
    }
  }

  // 2. Mikrofonu Aç/Kapat
  Future<void> toggleMic(bool isOn) async {
    try {
      if (isOn) {
        await room.localParticipant?.setMicrophoneEnabled(true);
        debugPrint('🎤 Mikrofon AÇILDI');
      } else {
        await room.localParticipant?.setMicrophoneEnabled(false);
        debugPrint('🔇 Mikrofon KAPATILDI');
      }
    } catch (e) {
      debugPrint('Mikrofon Hatası: $e');
    }
  }

  // 3. Odadan Çıkış
  Future<void> disconnect() async {
    await room.disconnect();
  }
}
