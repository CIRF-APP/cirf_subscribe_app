import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Common/global_instance.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';

class MusicControlService {
  final Map<String, AudioFile> audioDatabase = audioDatabaseService.audioDatabase;

  Future<void> playFromCard(MusicModel target) async {
    if(audioDatabase[target.audioName] != null) {
      audioDatabase.forEach((String key, AudioFile value) async {
        key == target.audioName ? await value.audioPlay() : await value.audioStop();
      });
    }
  }

  Future<void> playFromButton(MusicModel target) async {
    if(audioDatabase[target.audioName] != null) {
      final AudioFile value = audioDatabase[target.audioName]!;
      value.isPlay() ? await value.audioPause() : await value.audioPlay();
    }
  }

  Future<void> setSeekPosition(MusicModel target, double value) async {
    await audioDatabase[target.audioName]?.setPosition(value);
  }
}