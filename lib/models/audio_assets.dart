import 'package:assets_audio_player/assets_audio_player.dart';

String filePath = "assets/audios/rin.mp3";

class AudioPlayer {
  static final AudioPlayer _instance = AudioPlayer._internal();
  factory AudioPlayer() => _instance;

  AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  AssetsAudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayer._internal();

  play() {
    _audioPlayer.open(
      Audio(filePath),
    );
  }

  pause() {
    _audioPlayer.stop();
  }
}
