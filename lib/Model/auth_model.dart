// 認証モデル
abstract class AuthModel {
  AuthModel({required this.username, required this.password});

  final String username;
  final String password;
}

// ログイン用
class LoginCredentials extends AuthModel {
  LoginCredentials({required String username, required String password}) : super(username: username, password: password);
}

// パスワード変更モデル
abstract class ConfirmModel {
  ConfirmModel({required this.newPass, required this.confirmPass});

  final String newPass;
  final String confirmPass;
}

// パスワード確認用
class PasswordCredentials extends ConfirmModel {
  PasswordCredentials({required String newPass, required String confirmPass}) : super(newPass: newPass, confirmPass: confirmPass);
}
