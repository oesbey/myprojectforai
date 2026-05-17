// ELI5: Bu bir "Sözleşme". LiveKit de gelse, Agora da gelse
// "Mikrofonu aç", "Odaya gir" gibi komutları bu isimle yapmak zorundalar.
abstract class VoiceProviderInterface {
  Future<void> init();
  Future<void> joinRoom(String roomId);
  Future<void> leaveRoom();
  Future<void> toggleMic(bool isOn);
}
