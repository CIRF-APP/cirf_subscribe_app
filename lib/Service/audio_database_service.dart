import 'dart:async';
import 'package:cirf_subscription_app/Common/api_client.dart';
import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Model/audio_data_model.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:flutter/services.dart' show rootBundle;


class AudioDatabaseService {
  final List<MusicModel> musicDatabase = <MusicModel>[];
  final Map<String, AudioFile> audioDatabase = <String, AudioFile>{};

  Future<void> loadAudioData() async {
    final AudioDataList model = AudioDataList.emptyModel();

    await fetchApiResult('https://cjb84iihii.execute-api.ap-northeast-1.amazonaws.com/audioAccess-Stage', model);

    print(model.audio_data_list.length);
    for (final AudioData elem in model.audio_data_list) {
      final AudioFile audioFile = AudioFile();
      await audioFile.open(elem.AudioURL);
      audioDatabase[elem.AudioTitle] = audioFile;

      musicDatabase.add(MusicModel(
        audioName: elem.AudioTitle,
        audioFile: elem.AudioURL,
        imageFile: elem.ImageURL,
        musicLength: audioFile.getAudioLength(),
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

  void close() {
    audioDatabase.forEach((String key, AudioFile value) async {
      await value.close();
    });
    audioDatabase.clear();
  }
}
