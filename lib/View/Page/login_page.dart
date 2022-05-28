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
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = Provider.of<LoginBloc>(context);
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;
    String userName = '';
    String passWord = '';
    bool pushButton = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: HexColor('#FFF0D8'),
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
                      InputForm(
                        title: 'ユーザーID',
                        //inputFormController: userIdController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        onChanged: (String text) {
                          userName = text;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputForm(
                        title: 'パスワード',
                        //inputFormController: passwordController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        isMask: true,
                        onChanged: (String text) {
                          passWord = text;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/sign_up');
                          },
                          child: FixedText(
                            size: 12,
                            text: 'アカウントをお持ちで無い場合',
                            color: HexColor('#0019DB'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<LoginCredentials>(
                        stream: loginBloc.loginStateAction,
                        builder: (BuildContext context, AsyncSnapshot<LoginCredentials> inputData) {
                          return FutureBuilder<AuthFlowStatus?>(
                            future: loginBloc.fetchLoginResult(inputData.data),
                            builder: (BuildContext context, AsyncSnapshot<AuthFlowStatus?> loginResult) {
                              if (loginResult.connectionState == ConnectionState.done) {
                                // Widgetの描画が完了かつstatusがtrueの時のみ遷移先判別
                                WidgetsBinding.instance!.addPostFrameCallback((_) {
                                  if (pushButton) {
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
                                                pushButton = false;
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
                                                pushButton = false;
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
                                                pushButton = false;
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
                                                pushButton = false;
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
                                                pushButton = false;
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
                                });
                                return ProgressButton(
                                  text: 'ログイン',
                                  textSize: 18,
                                  height: 48,
                                  width: displayWidth - 40,
                                  btnColor: HexColor('#FFA61C'),
                                  textColor: HexColor('#FFFFFF'),
                                  onPressed: () async {
                                    print('onPressed');
                                    // 遷移先判別を行うために"true"へ変更
                                    pushButton = true;
                                    FocusScope.of(context).unfocus();
                                    loginBloc.changeAuthAction.add(LoginCredentials(
                                      username: userName,
                                      password: passWord,
                                    ));
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
