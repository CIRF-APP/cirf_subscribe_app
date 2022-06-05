import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

// ログイン処理用Bloc
class LoginBloc {
  LoginBloc() {
    sinkLoginData();
  }

  // 入力(ログインボタン押下時の処理)
  final BehaviorSubject<LoginCredentials> loginController = BehaviorSubject<LoginCredentials>();

  Sink<LoginCredentials> get changeAuthAction => loginController.sink;

  // 出力(ログインボタン押下時の処理結果)
  final BehaviorSubject<LoginCredentials> pageController = BehaviorSubject<LoginCredentials>();

  Stream<LoginCredentials> get loginStateAction => pageController.stream;

  // ログインの結果を返す処理
  Future<AuthFlowStatus?> fetchLoginResult(LoginCredentials? credentials) async {
    final AuthService service = AuthService();
    if (credentials == null) {
      return null;
    } else {
      return service.loginWithCredentials(credentials);
    }
  }

  // セッション結果
  Future<AuthFlowStatus> fetchSession() {
    final AuthService service = AuthService();
    return service.checkAuthStatus();
  }

  // 入力項目を渡す処理
  void sinkLoginData() {
    loginController.listen((LoginCredentials value) {
      pageController.sink.add(value);
    });
  }

  // Controllerを閉じる処理
  void dispose() {
    loginController.close();
    pageController.close();
  }
}
