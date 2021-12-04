import 'package:audioplayers/audioplayers.dart';

class AudioController {
  AudioController() {
    _fileName = <String>['music/bgm1.mp3', 'music/bgm2.mp3', 'music/bgm3.mp3'];
    _playState = <int>[];
    _audioPlayers = <AudioPlayer?>[];
    for (int i = 0; i < _fileName.length; i++) {
      _playState.add(0);
      _audioPlayers.add(null);
    }

    _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );
    _cache.loadAll(_fileName);
  }

  late AudioCache _cache;
  late List<String> _fileName;
  late List<int> _playState;
  late List<AudioPlayer?> _audioPlayers;

  void playAudio(int index) async {
    for(int i = 0; i < _audioPlayers.length; i++) {
      if (_audioPlayers[i] != null && i != index) {
        _audioPlayers[i]!.stop();
        _playState[i] = 0;
      }
    }

    if (_playState[index] == 2 && _audioPlayers[index] != null)
      _audioPlayers[index]!.resume();
    else
      _audioPlayers[index] = await _cache.play(_fileName[index]);

    _playState[index] = 1;
  }

  void playListen(){
  }

  void pauseAudio(int index) {
    _audioPlayers[index]!.pause();
    _playState[index] = 2;
  }

  void stopAudio(int index) {
    _audioPlayers[index]!.stop();
    _playState[index] = 0;
  }

  bool isPlay(int index) {
    return _playState[index] == 1;
  }
}
