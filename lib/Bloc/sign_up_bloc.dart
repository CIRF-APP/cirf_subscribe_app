import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

// ログイン処理用Bloc
class SignUpBloc {
  SignUpBloc() {
    sinkSignUpData();
  }

  // 入力
  final BehaviorSubject<SignUpCredentials> inputController = BehaviorSubject<SignUpCredentials>();

  Sink<SignUpCredentials> get pushButton => inputController.sink;

  // 出力
  final BehaviorSubject<SignUpCredentials> sendController = BehaviorSubject<SignUpCredentials>();

  Stream<SignUpCredentials> get signUpData => sendController.stream;

  // サインアップの結果を返す処理
  Future<SignUpFlowStatus?> fetchSignUpResult(SignUpCredentials? credentials) async {
    final AuthService service = AuthService();
    print(credentials);
    if (credentials == null) {
      return null;
    } else {
      return service.createAccount(credentials);
    }
  }

  // 入力項目を渡す処理
  void sinkSignUpData() {
    inputController.listen((SignUpCredentials value) {
      print('sinkSignUpData ${value.username}');
      sendController.sink.add(value);
    });
  }

  // Controllerを閉じる処理
  void dispose() {
    inputController.close();
    sendController.close();
  }
}
