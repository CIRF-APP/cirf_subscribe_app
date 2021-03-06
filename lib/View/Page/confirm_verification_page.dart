import 'package:cirf_subscription_app/Bloc/sign_up_bloc.dart';
import 'package:cirf_subscription_app/Bloc/verification_bloc.dart';
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
class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _VerificationPageState();
  }
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController verificationController = TextEditingController();
  String credentials = '';

  // build制御のための変数
  // TODO(you): リファクタリング(より良い方法を検討)
  bool pushButton = false;

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = Provider.of<SignUpBloc>(context);
    final VerificationBloc verificationBloc = Provider.of<VerificationBloc>(context);
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
                        title: '認証コード',
                        inputFormController: verificationController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed('/sign_up');
                          },
                          child: FixedText(
                            size: 12,
                            text: '認証コードを再送信',
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
                          return StreamBuilder<String>(
                            stream: verificationBloc.confirmAction,
                            builder: (BuildContext context, AsyncSnapshot<String> verificationCode) {
                              return FutureBuilder<VerificationFlowStatus?>(
                                future: verificationBloc.fetchConfirmResult(userData.data, verificationCode.data),
                                builder: (BuildContext context, AsyncSnapshot<VerificationFlowStatus?> verificationResult) {
                                  if (verificationResult.connectionState == ConnectionState.done) {
                                    // Widgetの描画が完了かつpushButtonがtrueの時のみ遷移先判別
                                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                                      if (pushButton == true) {
                                        switch (verificationResult.data) {
                                          case VerificationFlowStatus.success:
                                            Navigator.of(context).pushReplacementNamed('/top');
                                            break;
                                          case VerificationFlowStatus.fail:
                                            print('認証番号入力で失敗');
                                            pushButton = false;
                                            break;
                                          default:

                                        }
                                      }
                                    });
                                    return ProgressButton(
                                      text: 'ログイン',
                                      textSize: 18,
                                      height: 48,
                                      width: displayWidth - 40,
                                      btnColor: HexColor('#000000'),
                                      textColor: HexColor('#FFFFFF'),
                                      onPressed: () async {
                                        // 遷移先判別を行うために"true"へ変更
                                        pushButton = true;
                                        FocusScope.of(context).unfocus();
                                        // 認証コード入力項目
                                        final String verification = verificationController.text.trim();
                                        verificationBloc.checkVerification.add(verification);
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
