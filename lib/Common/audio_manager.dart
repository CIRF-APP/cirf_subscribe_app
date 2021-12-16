
import 'package:cigarandcoffee/Common/audio_controller.dart';

class AudioManager {
  AudioManager() {
    _audioDataBase['bgm1'] = AudioFile('bgm1');
  }

  Map<String, AudioFile> _audioDataBase = Map<String, AudioFile>();

  AudioFile find(String key) {
    return _audioDataBase[key] ?? AudioFile('no-data');
  }


}