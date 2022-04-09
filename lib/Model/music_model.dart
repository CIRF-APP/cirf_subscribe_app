
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

  String audioName;
  String audioFile;
  String imageFile;
}
