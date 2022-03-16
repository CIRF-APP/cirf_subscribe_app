import 'package:rxdart/rxdart.dart';

class PlayButtonBloc {
  PlayButtonBloc(){
    actionController.listen((bool value) {
      writeController.sink.add(value);
    });
  }

  final BehaviorSubject<bool> actionController = BehaviorSubject<bool>();

  Sink<bool> get pushButton => actionController.sink;

  final BehaviorSubject<bool> writeController = BehaviorSubject<bool>();

  Stream<bool> get playStatus => writeController.stream;

  void dispose() {
    actionController.close();
    writeController.close();
  }
}