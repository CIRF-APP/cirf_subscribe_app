import 'package:just_audio/just_audio.dart';

class AudioFile {
  AudioFile(String fileName) {
    _audioPlayer.setAsset('assets/music/' + fileName + '.mp3');
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  void open(String fileName) {
    _audioPlayer.setAsset('assets/music/' + fileName + '.mp3');
  }

  void close() {
    _audioPlayer.dispose();
  }

  void audioPlay() {
    _audioPlayer.play();
  }

  void audioPause() {
    _audioPlayer.pause();
  }

  void audioStop() {
    _audioPlayer.stop();
  }

  bool isPlay() {
    return _audioPlayer.playing;
  }
}
