import 'dart:async';
import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:flutter/services.dart' show rootBundle;


class AudioDatabaseService {
  final List<MusicModel> musicDatabase = <MusicModel>[];
  final Map<String, AudioFile> audioDatabase = <String, AudioFile>{};

  Future<void> loadAudioData() async {
    final String fileData = await rootBundle.loadString('assets/audio_data.csv');
    final List<String> lines = fileData.split('\n');

    for (final String line in lines) {
      final List<String> elems = line.split(',');
      final AudioFile audioFile = AudioFile();
      await audioFile.open(elems[1]);
      audioDatabase[elems[0]] = audioFile;

      musicDatabase.add(MusicModel(
        audioName: elems[0],
        audioFile: elems[1],
        imageFile: elems[2].replaceAll('\r', ''),
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
