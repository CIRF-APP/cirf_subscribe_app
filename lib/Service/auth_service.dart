import 'dart:async';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:flutter/material.dart';

/// AmplifyAuth(外部連携)を使用するためテストコードの記載なし
// 認証処理
class AuthService {
  // IDトークン格納用のkeyの設定
  String key = 'id_token';

  // 認証状態確認
  // アプリ起動時にまず確認
  Future<AuthFlowStatus> checkAuthStatus() async {
    try {
      // セッション確認
      // アクセストークン取得用のセッション確認
      final AuthSession session = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      // isSignedがtrueの場合はsessionログイン
      if (session.isSignedIn) {
        final CognitoAuthSession token = session as CognitoAuthSession;
        final String idToken = token.userPoolTokens!.idToken.toString();
        print(idToken);
        return AuthFlowStatus.success;
      } else {
        // ログインには失敗
        return AuthFlowStatus.fail;
      }
    } on AuthException catch (authError) {
      // エラー(初回起動時はここに入るのが正)
      // エラー：ログイン画面に遷移
      debugPrint('Could not session check - ${authError.message}');
      return AuthFlowStatus.error;
    }
  }

  // ログイン処理
  Future<AuthFlowStatus> loginWithCredentials(LoginCredentials model) async {
    try {
      // 入力されたusernameとpasswordで認証成功するかの判別4
      final SignInResult result = await Amplify.Auth.signIn(username: model.username, password: model.password);
      // サインインされた状態であればセッション参照
      if (result.isSignedIn) {
        final AuthSession session = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true),
        );
        // IDトークンの取得
        final CognitoAuthSession token = session as CognitoAuthSession;
        final String idToken = token.userPoolTokens!.idToken.toString();
        print(idToken);
        return AuthFlowStatus.success;
        // 失敗
      } else {
        debugPrint('User could not be signed in');
        // ログインされていない状態
        // パスワード変更要求時はここに入る
        return AuthFlowStatus.fail;
      }
    } on AuthException catch (authError) {
      // エラー
      debugPrint('Could not login - ${authError.message}');
      // 保証：session取得にエラーが発生しログインが行えなくなった際の対処
      logOut();
      if (Platform.isIOS) {
        // iOSの場合
        switch (authError.message) {
          // 項目未入力
          case 'Username is required to signIn':
            return AuthFlowStatus.id_error;
          // ユーザが存在しない
          case 'User does not exist.':
            return AuthFlowStatus.user_error;
          // 入力間違い
          case 'Incorrect username or password.':
            return AuthFlowStatus.pass_error;
          // アカウントが無効化
          case 'User is disabled.':
            return AuthFlowStatus.disable_error;
          // その他エラー(オフライン実行など)
          case 'Unexpected error occurred with message: An unknown error occurred':
            return AuthFlowStatus.error;
          // その他エラー
          default:
            return AuthFlowStatus.error;
        }
      } else {
        // Androidの場合
        switch (authError.message) {
          // 項目未入力
          case 'One or more parameters are incorrect.':
            return AuthFlowStatus.id_error;
          // ユーザが存在しない
          case 'User not found in the system.':
            return AuthFlowStatus.user_error;
          // 入力間違い
          case 'Failed since user is not authorized.':
            return AuthFlowStatus.pass_error;
          // その他エラー
          default:
            return AuthFlowStatus.error;
        }
      }
    } on Exception catch (e) {
      print(e.toString());
      return AuthFlowStatus.error;
    }
  }

  // サインアップ
  Future<SignUpFlowStatus> createAccount(SignUpCredentials model) async {
    try {
      if (model.password == model.confirmPass) {
        await Amplify.Auth.signUp(
          username: model.username,
          password: model.password,
          options: CognitoSignUpOptions(
            userAttributes: <CognitoUserAttributeKey, String>{
              CognitoUserAttributeKey.email: model.username,
            },
          ),
        );

        return SignUpFlowStatus.success;
      } else {
        return SignUpFlowStatus.fail;
      }
    } on AmplifyException catch (authError) {
      print('createAccount ${authError.message}');
      return SignUpFlowStatus.fail;
    }
  }

  Future<VerificationFlowStatus> confirmAccount(String userName, String confirmCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: userName,
        confirmationCode: confirmCode,
      );

      return VerificationFlowStatus.success;
    } on AmplifyException catch (authError) {
      print('confirmAccount ${authError.message}');
      return VerificationFlowStatus.fail;
    }
  }

  // ログアウト処理
  Future<AuthFlowStatus> logOut() async {
    try {
      // ログアウトを実行
      await Amplify.Auth.signOut();
      // ログイン画面に遷移
      return AuthFlowStatus.error;
    } on AuthException catch (authError) {
      // ログアウト失敗
      debugPrint('Could not log out - ${authError.message}');
      return AuthFlowStatus.error;
    }
  }

  // パスワード変更
  Future<ChangePassFlowStatus> changeFirstPass(PasswordCredentials model) async {
    try {
      // TODO(you): セッション内にログイン情報を格納する
      if (model.newPass == model.confirmPass) {
        await Amplify.Auth.confirmSignIn(confirmationValue: model.confirmPass);
        return ChangePassFlowStatus.success;
      } else {
        print('Not Complete Confirm Pass');
        // 非同期処理にdelayをかけることで2重表示を抑制
        await Future<dynamic>.delayed(const Duration(milliseconds: 100));
        return ChangePassFlowStatus.fail;
      }
    } on AmplifyException catch (authError) {
      print('Could not change Pass - ${authError.message}');
      if (Platform.isIOS) {
        // iOSの場合
        switch (authError.message) {
          // 8文字未満
          case 'Password does not conform to policy: Password not long enough':
            return ChangePassFlowStatus.reg_error;
          // 大文字なし
          case 'Password does not conform to policy: Password must have uppercase characters':
            return ChangePassFlowStatus.reg_error;
          // 数字なし
          case 'Password does not conform to policy: Password must have numeric characters':
            return ChangePassFlowStatus.reg_error;
          // 入力なし
          case 'challengeResponse is required to confirmSignIn':
            return ChangePassFlowStatus.input_error;
          // セッションなし
          case 'Invalid session for the user, session is expired.':
            return ChangePassFlowStatus.error;
          // その他エラー
          default:
            return ChangePassFlowStatus.error;
        }
      } else {
        // Androidの場合
        switch (authError.message) {
          // 入力制限違反
          case 'The password given is invalid.':
            return ChangePassFlowStatus.reg_error;
          // 入力なし
          case 'One or more parameters are incorrect.':
            return ChangePassFlowStatus.input_error;
          // セッションなし
          case 'Failed since user is not authorized.':
            return ChangePassFlowStatus.error;
          // その他エラー
          default:
            return ChangePassFlowStatus.error;
        }
      }
    } on Exception catch (e) {
      print(e.toString());
      return ChangePassFlowStatus.error;
    }
  }
}
