import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Common/global_instance.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';

class MusicControlService {
  final Map<String, AudioFile> audioDatabase = audioDatabaseService.audioDatabase;

  Future<void> playOneFile(MusicModel target) async {
    if(audioDatabase[target.audioName] != null) {
      audioDatabase.forEach((String key, AudioFile value) async {
        if (key == target.audioName) {
          value.isPlay() ? await value.audioPause() : await value.audioPlay();
        } else {
          await value.audioStop();
        }
      });
    }
  }

  Future<void> setSeekPosition(MusicModel target, double value) async {
    await audioDatabase[target.audioName]?.setPosition(value);
  }
}