import 'package:rxdart/rxdart.dart';

class PlayButtonBloc {
  PlayButtonBloc(){
    pushButton();
  }

  final BehaviorSubject<bool> actionController = BehaviorSubject<bool>();

  final BehaviorSubject<bool> writeController = BehaviorSubject<bool>();

  void pushButton() {
    actionController.listen((bool value) {
      writeController.sink.add(value);
    });
  }

  void dispose() {
    actionController.close();
    writeController.close();
  }
}