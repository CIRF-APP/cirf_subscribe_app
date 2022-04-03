
class MusicModel {
  MusicModel({
    required this.audioName,
    required this.audioFile,
    required this.imageFile,
    required this.musicLength,
  });

  factory MusicModel.emptyModel() {
    return MusicModel(
      audioName: '',
      audioFile: '',
      imageFile: '',
      musicLength: '',
    );
  }

  String audioName;
  String audioFile;
  String imageFile;
  String musicLength;
}
