import 'package:just_audio/just_audio.dart';

class AudioFile {
  AudioFile();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> open(String fileName) async {
    await _audioPlayer.setAsset('assets/music/$fileName');
  }

  Future<void> close() async {
    await _audioPlayer.dispose();
  }

  Future<void> audioPlay() async {
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

  Stream<Duration> getPosition() {
    return _audioPlayer.positionStream;
  }

  Future<void> setPosition(double value) async {
    final double pos = value * getTotalSecond();
    await _audioPlayer.seek(Duration(seconds: pos.toInt()));
  }

  int getTotalSecond() {
    final Duration length = _audioPlayer.duration ?? Duration.zero;
    return length.inSeconds;
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

    String sStr = seconds.toString();
    String mStr = minutes.toString();
    String hStr = hours.toString();

    if(sStr.length == 1)
      sStr = '0$sStr';
    if(mStr.length == 1)
      mStr = '0$mStr';
    if(hStr.length == 1)
      hStr = '0$hStr';

    String nowTime = hStr == '00' ? '' : hStr;
    nowTime += '$mStr:$sStr';
    return nowTime;
  }
}
