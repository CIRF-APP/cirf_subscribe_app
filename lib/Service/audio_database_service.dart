import 'dart:async';
import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class AudioDatabaseService {
  final List<MusicModel> musicDatabase = <MusicModel>[];
  final Map<String, AudioFile> audioDataBase = <String, AudioFile>{};

  Future<void> loadAudioData() async {
    final String fileData = await rootBundle.loadString('assets/audio_data.csv');
    final List<String> lines = fileData.split('\n');

    for (final String line in lines) {
      final List<String> elems = line.split(',');
      musicDatabase.add(MusicModel(
        audioName: elems[0],
        audioFile: elems[1],
        imageFile: elems[2].replaceAll('\r', ''),
      ));
    }
  }

  List<MusicModel> searchMusic(String word) {
    final List<MusicModel> result = <MusicModel>[];
    for (final MusicModel model in musicDatabase) {
      if(model.audioName.toLowerCase().contains(word.toLowerCase())){
        result.add(model);
      }
    }
    return result;
  }

  Future<void> playOneFile(String target) async {
    if(audioDataBase[target] != null) {
      audioDataBase.forEach((String key, AudioFile value) async {
        if (key == target) {
          value.isPlay() ? await value.audioPause() : await value.audioPlay();
        } else {
          await value.audioStop();
        }
      });
    }
  }

  void close() {
    audioDataBase.forEach((String key, AudioFile value) async {
      await value.close();
    });
    audioDataBase.clear();
  }
}
