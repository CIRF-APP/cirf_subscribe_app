import 'package:audioplayers/audioplayers.dart';

class AudioController {
  AudioController() {
    fileName = <String>['music/bgm1.mp3', 'music/bgm2.mp3', 'music/bgm3.mp3'];
    isPlaying = <bool>[];
    for (int i = 0; i < fileName.length; i++) isPlaying.add(false);

    _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );
    _cache.loadAll(fileName);
  }

  late AudioCache _cache;
  late List<String> fileName;
  late List<bool> isPlaying;
  AudioPlayer? audioPlayer;

  void playAudio(int index) async {
    audioPlayer = await _cache.play(fileName[index]);
    isPlaying[index] = true;
  }

  void pauseAudio(int index) {
    audioPlayer!.pause();
    isPlaying[index] = false;
  }

  void stopAudio(int index) {
    audioPlayer!.stop();
    isPlaying[index] = false;
  }

  bool isPlay(int index) {
    return isPlaying[index];
  }
}
