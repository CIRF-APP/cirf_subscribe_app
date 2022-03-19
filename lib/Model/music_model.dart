import 'package:hive_flutter/hive_flutter.dart';

part 'music_model_gen.dart';

@HiveType(typeId: 0)
class MusicModel {
  MusicModel({
    required this.audioName,
    required this.audioFile,
    required this.imageFile,
  });

  factory MusicModel.emptyModel() {
    return MusicModel(
      audioName: '',
      audioFile: '',
      imageFile: '',
    );
  }

  @HiveField(0)
  String audioName;

  @HiveField(1)
  String audioFile;

  @HiveField(2)
  String imageFile;
}
