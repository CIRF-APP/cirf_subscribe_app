import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc {
  ChangePasswordBloc() {
    sinkPassData();
  }

  // 入力(パスワード設定ボタン押下時の処理)
  final BehaviorSubject<PassChangeCredentials> changePassController = BehaviorSubject<PassChangeCredentials>();

  Sink<PassChangeCredentials> get changeAction => changePassController.sink;

  // 出力(パスワード設定ボタン押下時の処理結果)
  final BehaviorSubject<PassChangeCredentials> pageController = BehaviorSubject<PassChangeCredentials>();

  Stream<PassChangeCredentials> get changePass => pageController.stream;

  // パスワード変更の結果を返す処理
  Future<ChangePassFlowStatus?> fetchChangePassResult(PassChangeCredentials? credentials) async {
    final AuthService service = AuthService();
    if (credentials == null) {
      return null;
    } else {
      return service.changePassword(credentials);
    }
  }

  // 入力項目を渡す処理
  void sinkPassData() {
    changePassController.listen((PassChangeCredentials value) {
      pageController.sink.add(value);
    });
  }

  // Controllerを閉じる処理
  void dispose() {
    changePassController.close();
    pageController.close();
  }
}
