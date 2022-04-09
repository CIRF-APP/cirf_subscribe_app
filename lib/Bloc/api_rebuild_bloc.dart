import 'package:rxdart/rxdart.dart';

// API通信を行うBlocで、再接続(FutureBuilderの再呼び出し)を行うための抽象クラス

/* 使い方
 * API通信を行うBlocにこのクラスを継承させる
 * 継承先のBlocのコンストラクタで、listenRebuild()を呼び出す
 */
class APIRebuildBloc {
  // 入力
  final BehaviorSubject<void> detectRebuild = BehaviorSubject<void>();

  Sink<void> get toRebuild => detectRebuild.sink;

  // 出力
  final BehaviorSubject<void> writeRebuild = BehaviorSubject<void>();

  Stream<void> get rebuildStream => writeRebuild.stream;

  void listenRebuild() {
    detectRebuild.listen((_) {
      writeRebuild.sink.add(null);
    });
  }
}
