import 'audio_file.dart';

class AudioManager {
  AudioManager() {
    _audioDataBase['bgm1'] = AudioFile('bgm1');
    _audioDataBase['bgm2'] = AudioFile('bgm2');
    _audioDataBase['bgm3'] = AudioFile('bgm3');
  }

  Map<String, AudioFile> _audioDataBase = Map<String, AudioFile>();

  AudioFile find(String key) {
    return _audioDataBase[key] ?? AudioFile('no-data');
  }

  Future<void> playOneFile(String target) async {
    _audioDataBase.forEach((String key, AudioFile value) async {
      if (key == target) {
        value.isPlay() ? await value.audioPause() : await value.audioPlay();
      } else {
        await value.audioStop();
      }
    });
  }

  void close() {
    _audioDataBase.forEach((String key, AudioFile value) async {
      await value.close();
    });
    _audioDataBase.clear();
  }
}
