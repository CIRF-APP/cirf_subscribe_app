import 'package:audioplayers/audioplayers.dart';

class AudioController {
  AudioController() {
    _fileName = <String>['music/bgm1.mp3', 'music/bgm2.mp3', 'music/bgm3.mp3'];
    _isPlaying = <bool>[];
    _audioPlayers = <AudioPlayer?>[];
    for (int i = 0; i < _fileName.length; i++) {
      _isPlaying.add(false);
      _audioPlayers.add(null);
    }

    _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );
    _cache.loadAll(_fileName);
  }

  late AudioCache _cache;
  late List<String> _fileName;
  late List<bool> _isPlaying;
  late List<AudioPlayer?> _audioPlayers;

  void playAudio(int index) async {
    if (_audioPlayers[index] == null)
      _audioPlayers[index] = await _cache.play(_fileName[index]);
    else {
      //int res = await _audioPlayers[index]!.play(_fileName[index], isLocal: true);
      _audioPlayers[index]!.resume();
      // print(res);
    }
    _isPlaying[index] = true;
  }

  void pauseAudio(int index) {
    _audioPlayers[index]!.pause();
    _isPlaying[index] = false;
  }

  void stopAudio(int index) {
    _audioPlayers[index]!.stop();
    _isPlaying[index] = false;
  }

  bool isPlay(int index) {
    return _isPlaying[index];
  }
}
