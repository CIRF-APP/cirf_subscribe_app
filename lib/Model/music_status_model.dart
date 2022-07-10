import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';

class MusicStatusModel {
  MusicStatusModel({
    required this.status,
    required this.model,
  });

  MusicPageStatus status;
  MusicModel model;
}
