import 'package:cirf_subscription_app/Bloc/sign_up_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/input_form.dart';
import 'package:cirf_subscription_app/View/Molecule/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ログイン画面
// TextField使用のためStatefulで記載(処理自体はBlocパターンで管理)
// 入力した文字を入力フォームに保持するため
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = Provider.of<SignUpBloc>(context);
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;
    String userName = '';
    String passWord = '';
    String confirmPass = '';
    bool status = false;

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
                      // TODO(you): Android入力フォーム使用時のログ確認
                      InputForm(
                        title: 'ユーザーID',
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
                      InputForm(
                        title: 'パスワード確認',
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        isMask: true,
                        onChanged: (String text) {
                          confirmPass = text;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(
                          // TODO(you): パスワード忘れ画面の実装
                          onPressed: () {},
                          child: FixedText(
                            size: 12,
                            text: 'パスワードをお忘れの場合',
                            color: HexColor('#0019DB'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<SignUpCredentials>(
                        stream: signUpBloc.signUpData,
                        builder: (BuildContext context, AsyncSnapshot<SignUpCredentials> userData) {
                          return FutureBuilder<SignUpFlowStatus?>(
                            future: signUpBloc.fetchSignUpResult(userData.data),
                            builder: (BuildContext context, AsyncSnapshot<SignUpFlowStatus?> loginResult) {
                              if (loginResult.connectionState == ConnectionState.done) {
                                // Widgetの描画が完了かつstatusがtrueの時のみ遷移先判別
                                WidgetsBinding.instance!.addPostFrameCallback((_) {
                                  print('WidgetBinding ${loginResult.data}');
                                  switch (loginResult.data) {
                                    case SignUpFlowStatus.success:
                                      Navigator.of(context).pushNamed('/verification');
                                      break;

                                    case SignUpFlowStatus.fail:
                                      print('失敗島');
                                      break;

                                    default:
                                      print('null');
                                      break;
                                  }
                                });
                                return ProgressButton(
                                  text: '登録',
                                  textSize: 18,
                                  height: 48,
                                  width: displayWidth - 40,
                                  btnColor: HexColor('#FFA61C'),
                                  textColor: HexColor('#FFFFFF'),
                                  onPressed: () async {
                                    // 遷移先判別を行うために"true"へ変更
                                    status = true;
                                    FocusScope.of(context).unfocus();
                                    signUpBloc.pushButton.add(SignUpCredentials(
                                      username: userName,
                                      password: passWord,
                                      confirmPass: confirmPass,
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
