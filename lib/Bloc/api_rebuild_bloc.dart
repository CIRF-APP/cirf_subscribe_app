import 'package:rxdart/rxdart.dart';

// API通信を行うBlocで、再接続(FutureBuilderの再呼び出し)を行うための抽象クラス

/* 使い方
 * API通信を行うBlocにこのクラスを継承させる
 * 継承先のBlocのコンストラクタで、listenRebuild()を呼び出す
 */
abstract class APIRebuildBloc {
  // 入力
  final BehaviorSubject<bool> detectRebuild = BehaviorSubject<bool>();

  Sink<bool> get toRebuild => detectRebuild.sink;

  // 出力
  final BehaviorSubject<bool> writeRebuild = BehaviorSubject<bool>();

  Stream<bool> get rebuildStream => writeRebuild.stream;

  void listenRebuild() {
    detectRebuild.listen(
      (bool value) {
        if (value) {
          writeRebuild.sink.add(true);
        }
      },
    );
  }
}
