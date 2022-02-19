import 'package:just_audio/just_audio.dart';

class AudioFile {
  AudioFile();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> open(String fileName) async {
    await _audioPlayer.setAsset('assets/music/' + fileName + '.mp3');
  }

  Future<void> close() async {
    await _audioPlayer.dispose();
  }

  Future<void> audioPlay() async {
    //print(_audioPlayer.processingState);
    while(_audioPlayer.processingState != ProcessingState.ready) {}
    await _audioPlayer.play();
  }

  Future<void> audioPause() async {
    await _audioPlayer.pause();
  }

  Future<void> audioStop() async {
    await _audioPlayer.stop();
    _audioPlayer.seek(null);
  }

  bool isPlay() {
    return _audioPlayer.playing;
  }

  Duration getPosition() {
    return _audioPlayer.position;
  }
}
