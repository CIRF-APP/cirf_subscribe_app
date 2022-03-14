import 'package:rxdart/rxdart.dart';

class SeekBarBloc {
  SeekBarBloc(){

  }

  final BehaviorSubject<double> seekJumpController = BehaviorSubject<double>();

  final BehaviorSubject<double> a = BehaviorSubject<double>();
}