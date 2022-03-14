import 'package:just_audio/just_audio.dart';

class AudioFile {
  AudioFile();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> open(String fileName) async {
    await _audioPlayer.setAsset('assets/music/$fileName.mp3');
    _audioPlayer.currentIndex
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

  Future<void> setPosition(double value) async {
    final Duration length = _audioPlayer.duration ?? Duration.zero;
    final int targetSecond = length.inSeconds * value as int;
    print(targetSecond);
    await _audioPlayer.seek(Duration(seconds: targetSecond));
  }

  double getTotalSecond() {
    final Duration length = _audioPlayer.duration ?? Duration.zero;
    final double total = length.inSeconds as double;
    return total;
  }

  String getAudioLength() {
    final Duration length = _audioPlayer.duration ?? Duration.zero;
    int seconds = length.inSeconds;
    int minutes = 0;
    int hours = 0;

    while(seconds >= 60) {
      minutes++;
      seconds -= 60;
    }

    while(minutes >= 60) {
      hours++;
      minutes -= 60;
    }

    String lengthTime = hours == 0 ? '' : '$hours:';
    lengthTime += '$minutes:$seconds';
    return lengthTime;
  }
}
