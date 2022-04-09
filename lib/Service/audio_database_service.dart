import 'dart:async';
import 'package:cirf_subscription_app/Common/api_client.dart';
import 'package:cirf_subscription_app/Model/audio_data_model.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';


class AudioDatabaseService {
  final List<MusicModel> musicDatabase = <MusicModel>[];

  Future<void> loadAudioData() async {
    final AudioDataList model = AudioDataList.emptyModel();

    await fetchApiResult('https://cjb84iihii.execute-api.ap-northeast-1.amazonaws.com/audioAccess-Stage', model);

    for (final AudioData elem in model.audio_data_list) {
      musicDatabase.add(MusicModel(
        audioName: elem.AudioTitle,
        audioFile: elem.AudioURL,
        imageFile: elem.ImageURL,
      ));
    }
  }

  List<MusicModel> searchMusic(String word) {
    final List<MusicModel> result = <MusicModel>[];
    if(word.isEmpty)
      return result;

    for (final MusicModel model in musicDatabase) {
      if(model.audioName.toLowerCase().startsWith(word.toLowerCase())){
        result.add(model);
      }
    }
    return result;
  }
}
