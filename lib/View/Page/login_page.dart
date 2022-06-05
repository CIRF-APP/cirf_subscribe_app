import 'package:cirf_subscription_app/Bloc/login_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/input_form.dart';
import 'package:cirf_subscription_app/View/Molecule/ios_style_dialog.dart';
import 'package:cirf_subscription_app/View/Molecule/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ログイン画面
// TextField使用のためStatefulで記載(処理自体はBlocパターンで管理)
// 入力した文字を入力フォームに保持するため
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginCredentials credentials = LoginCredentials(username: '', password: '');

  // build制御のための変数
  // TODO(you): リファクタリング(より良い方法を検討)
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = Provider.of<LoginBloc>(context);
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: HexColor('#FFFFFF'),
          height: displayHeight,
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      // TODO(you): Android入力フォーム使用時のログ確認
                      InputForm(
                        title: 'ユーザーID',
                        inputFormController: userIdController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputForm(
                        title: 'パスワード',
                        inputFormController: passwordController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        isMask: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      StreamBuilder<LoginCredentials>(
                        stream: loginBloc.loginStateAction,
                        builder: (BuildContext context, AsyncSnapshot<LoginCredentials> userData) {
                          return FutureBuilder<AuthFlowStatus?>(
                            future: loginBloc.fetchLoginResult(userData.data),
                            builder: (BuildContext context, AsyncSnapshot<AuthFlowStatus?> loginResult) {
                              if (loginResult.connectionState == ConnectionState.done) {
                                // Widgetの描画が完了かつstatusがtrueの時のみ遷移先判別
                                WidgetsBinding.instance!.addPostFrameCallback(
                                  (_) {
                                    // ログインボタン押下時
                                    // success：TopPage()
                                    // fail：ChangePassword()
                                    // error系：ダイアログ
                                    if (status == true) {
                                      switch (loginResult.data) {
                                        // 認証成功
                                        case AuthFlowStatus.success:
                                          Navigator.of(context).pushReplacementNamed('/top');
                                          break;
                                        // 認証成功(条件あり)
                                        case AuthFlowStatus.fail:
                                          Navigator.of(context).pushReplacementNamed('/pass_change');
                                          break;
                                        // 認証失敗：ID入力なし
                                        case AuthFlowStatus.id_error:
                                          showDialog<int>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return IOSStyleDialog(
                                                titleText: 'ユーザーIDを入力してください。',
                                                onPressButton1: () {
                                                  // 遷移先判別を行わないために"false"へ変更
                                                  status = false;
                                                  Navigator.pop(context);
                                                },
                                                button1Text: 'OK',
                                              );
                                            },
                                          );
                                          break;
                                        // 認証失敗：存在しないユーザー
                                        case AuthFlowStatus.user_error:
                                          showDialog<int>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return IOSStyleDialog(
                                                titleText: 'ユーザーIDまたはパスワードが間違っています。',
                                                onPressButton1: () {
                                                  // 遷移先判別を行わないために"false"へ変更
                                                  status = false;
                                                  Navigator.pop(context);
                                                },
                                                button1Text: 'OK',
                                              );
                                            },
                                          );
                                          break;
                                        // 認証失敗：入力ミス(idはOK、PassがNG)
                                        case AuthFlowStatus.pass_error:
                                          showDialog<int>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return IOSStyleDialog(
                                                titleText: 'ユーザーIDまたはパスワードが間違っています。',
                                                onPressButton1: () {
                                                  // 遷移先判別を行わないために"false"へ変更
                                                  status = false;
                                                  Navigator.pop(context);
                                                },
                                                button1Text: 'OK',
                                              );
                                            },
                                          );
                                          break;
                                        // 認証失敗：無効なユーザー
                                        case AuthFlowStatus.disable_error:
                                          showDialog<int>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return IOSStyleDialog(
                                                titleText: '無効なユーザです。',
                                                onPressButton1: () {
                                                  // 遷移先判別を行わないために"false"へ変更
                                                  status = false;
                                                  Navigator.pop(context);
                                                },
                                                button1Text: 'OK',
                                              );
                                            },
                                          );
                                          break;
                                        // 認証失敗：その他エラー
                                        case AuthFlowStatus.error:
                                          showDialog<int>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return IOSStyleDialog(
                                                titleText: '時間をおいて再度ログインをお願いします。',
                                                onPressButton1: () {
                                                  // 遷移先判別を行わないために"false"へ変更
                                                  status = false;
                                                  Navigator.pop(context);
                                                },
                                                button1Text: 'OK',
                                              );
                                            },
                                          );
                                          break;
                                        // nullの際
                                        default:
                                          break;
                                      }
                                    }
                                  },
                                );
                                return ProgressButton(
                                  text: 'ログイン',
                                  textSize: 18,
                                  height: 48,
                                  width: displayWidth - 40,
                                  btnColor: HexColor('#000000'),
                                  textColor: HexColor('#FFFFFF'),
                                  onPressed: () async {
                                    // 遷移先判別を行うために"true"へ変更
                                    status = true;
                                    FocusScope.of(context).unfocus();
                                    // ユーザネーム欄入力項目
                                    final String username = userIdController.text.trim();
                                    // パスワード欄入力項目
                                    final String password = passwordController.text.trim();
                                    // 入力項目をModelに格納
                                    credentials = LoginCredentials(username: username, password: password);
                                    loginBloc.changeAuthAction.add(credentials);
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProgressButton(
                        text: '新規アカウント作成',
                        textSize: 18,
                        height: 48,
                        width: displayWidth - 40,
                        btnColor: HexColor('#00BFFF'),
                        textColor: HexColor('#FFFFFF'),
                        onPressed: () async {
                          Navigator.of(context).pushNamed('/sign_up');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
