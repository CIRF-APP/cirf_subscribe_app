import 'audio_file.dart';

class AudioManager {
  AudioManager() {
    _audioDataBase['bgm1'] = AudioFile();
    _audioDataBase['bgm2'] = AudioFile();
    _audioDataBase['bgm3'] = AudioFile();
  }

  Map<String, AudioFile> _audioDataBase = Map<String, AudioFile>();

  Future<void> loadFiles() async {
    await _audioDataBase['bgm1']?.open('bgm1');
    await _audioDataBase['bgm2']?.open('bgm2');
    await _audioDataBase['bgm3']?.open('bgm3');
  }

  AudioFile? find(String key) {
    return _audioDataBase[key];
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
