import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:rxdart/rxdart.dart';

class MusicControlBloc {
  MusicControlBloc(){
    _buttonController.listen((bool value) {
      _statusController.sink.add(value);
    });
    _setMusicController.listen((MusicModel model) {
      targetData = model;
    });
    getNowTime();
  }

  // 入力(対象の音楽データ設定)
  final BehaviorSubject<MusicModel> _setMusicController = BehaviorSubject<MusicModel>();

  Sink<MusicModel> get setMusicData => _setMusicController.sink;

  // 入力(再生ボタンが押された)
  final BehaviorSubject<bool> _buttonController = BehaviorSubject<bool>();

  Sink<bool> get pushButton => _buttonController.sink;

  // 出力(音声の再生状態)
  final BehaviorSubject<bool> _statusController = BehaviorSubject<bool>();

  Stream<bool> get playStatus => _statusController.stream;

  // 入力(シークバーの時間)
  final BehaviorSubject<double> _seekMoveController = BehaviorSubject<double>();

  Sink<double> get moveSeek => _seekMoveController.sink;

  // 出力(現在時間)
  final BehaviorSubject<double> _nowSeekController = BehaviorSubject<double>();

  Stream<double> get nowTime => _nowSeekController.stream;

  // 対象の音声データ
  MusicModel targetData = MusicModel.emptyModel();

  // 対象の音声
  AudioFile targetAudio = AudioFile();

  void getNowTime() {
    _seekMoveController.listen((double value) {
      targetAudio.setPosition(value);
    });
  }

  Future<void> playFromCard() async {
    if(targetAudio.isSet())
      await targetAudio.close();
    await targetAudio.open(targetData.audioFile);
    targetAudio.audioPlay();
  }

  Future<void> playFromButton() async {
    targetAudio.isPlay() ? await targetAudio.audioPause() : await targetAudio.audioPlay();
  }

  void dispose() {
    _setMusicController.close();
    _buttonController.close();
    _statusController.close();
    _nowSeekController.close();
    _seekMoveController.close();
  }
}