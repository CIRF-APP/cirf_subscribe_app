
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmPasswordBloc {
  ConfirmPasswordBloc() {
    sinkPassData();
  }

  // 入力(パスワード設定ボタン押下時の処理)
  final BehaviorSubject<PasswordCredentials> confirmPassController = BehaviorSubject<PasswordCredentials>();

  Sink<PasswordCredentials> get changePageAction => confirmPassController.sink;

  // 出力(パスワード設定ボタン押下時の処理結果)
  final BehaviorSubject<PasswordCredentials> pageController = BehaviorSubject<PasswordCredentials>();

  Stream<PasswordCredentials> get confirmPassAction => pageController.stream;

  // パスワード変更の結果を返す処理
  Future<ChangePassFlowStatus?> fetchChangePassResult(PasswordCredentials? credentials) async {
    final AuthService service = AuthService();
    if (credentials == null) {
      return null;
    } else {
      return service.changeFirstPass(credentials);
    }
  }

  // 入力項目を渡す処理
  void sinkPassData() {
    confirmPassController.listen(
      (PasswordCredentials value) {
        pageController.sink.add(value);
      },
    );
  }

  // Controllerを閉じる処理
  void dispose() {
    confirmPassController.close();
    pageController.close();
  }
}
