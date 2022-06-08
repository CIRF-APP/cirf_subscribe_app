// ログイン用
class LoginCredentials {
  LoginCredentials({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

// パスワード確認用
class PasswordCredentials {
  PasswordCredentials({
    required this.newPass,
    required this.confirmPass,
  });

  final String newPass;
  final String confirmPass;
}


// サインアップ用
class SignUpCredentials {
  SignUpCredentials({
    required this.username,
    required this.password,
    required this.confirmPass,
  });

  final String username;
  final String password;
  final String confirmPass;
}

// パスワード変更用
class PassChangeCredentials {
  PassChangeCredentials({
    required this.oldPass,
    required this.newPass,
    required this.confirmPass,
  });

  final String oldPass;
  final String newPass;
  final String confirmPass;
}