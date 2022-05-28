import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

// ログイン処理用Bloc
class VerificationBloc {
  VerificationBloc() {
    sinkVerificationData();
  }

  // 入力
  final BehaviorSubject<String> verificationController = BehaviorSubject<String>();

  Sink<String> get checkVerification => verificationController.sink;

  // 出力
  final BehaviorSubject<String> pageController = BehaviorSubject<String>();

  Stream<String> get confirmAction => pageController.stream;

  // 認証コードの結果を返す処理
  Future<VerificationFlowStatus?> fetchConfirmResult(String? userName, String? verificationCode) async {
    final AuthService service = AuthService();
    if (userName == null || verificationCode == null) {
      return null;
    } else {
      return service.confirmAccount(userName, verificationCode);
    }
  }

  // 入力項目を渡す処理
  void sinkVerificationData() {
    verificationController.listen((String value) {
      pageController.sink.add(value);
    });
  }

  // Controllerを閉じる処理
  void dispose() {
    verificationController.close();
    pageController.close();
  }
}
