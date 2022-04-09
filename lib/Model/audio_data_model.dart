import 'package:cirf_subscription_app/Model/api_model.dart';

class AudioData {
  AudioData({
    required this.AudioTitle,
    required this.AudioURL,
    required this.ImageURL,
  });

  factory AudioData.emptyModel() {
    return AudioData(
      AudioTitle: '',
      AudioURL: '',
      ImageURL: '',
    );
  }

  factory AudioData.fromJson(Map<String, dynamic> json) {
    return AudioData(
      AudioTitle: json['AudioTitle'] as String,
      AudioURL: json['AudioURL'] as String,
      ImageURL: json['ImageURL'] as String,
    );
  }

  String AudioTitle;
  String AudioURL;
  String ImageURL;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'AudioTitle': AudioTitle,
      'AudioURL': AudioURL,
      'ImageURL': ImageURL,
    };
  }
}


class AudioDataList extends APIModel {
  AudioDataList({
    required this.audio_data_list,
  });

  factory AudioDataList.emptyModel() {
    return AudioDataList(
      audio_data_list: <AudioData>[],
    );
  }

  List<AudioData> audio_data_list = <AudioData>[];

  @override
  void fromJson(dynamic json) {
    final List<dynamic> jsonList = json as List<dynamic>;
    audio_data_list = jsonList.map((dynamic e) => AudioData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  dynamic toJson() {
    return audio_data_list.map((AudioData e) => e.toJson()).toList();
  }
}
