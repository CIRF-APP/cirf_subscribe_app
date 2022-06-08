import 'package:cirf_subscription_app/Bloc/change_pass_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/auth_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/input_form.dart';
import 'package:cirf_subscription_app/View/Molecule/ios_style_dialog.dart';
import 'package:cirf_subscription_app/View/Molecule/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// パスワード変更画面
class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _ChangePassState();
  }
}

class _ChangePassState extends State<ChangePassPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // build制御のための変数
  // TODO(you): リファクタリング(より良い方法を検討)
  bool pushButton = false;

  @override
  Widget build(BuildContext context) {
    final ChangePasswordBloc changePassBloc = Provider.of<ChangePasswordBloc>(context);
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const FixedText(
          text: 'パスワード変更',
          size: 20,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SimpleIcon(
            icon: Icons.chevron_left,
            color: HexColor('#000000'),
          ),
        ),
      ),
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
                        height: 30,
                      ),
                      InputForm(
                        title: '現在のパスワード',
                        hintColor: HexColor('#00000080'),
                        inputFormController: oldPasswordController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        //isMask: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputForm(
                        title: '新しいパスワード',
                        hintText: '8文字以上',
                        hintSize: 12,
                        hintColor: HexColor('#00000080'),
                        inputFormController: newPasswordController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        //isMask: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputForm(
                        title: 'パスワード確認',
                        hintText: '8文字以上',
                        hintColor: HexColor('#00000080'),
                        hintSize: 12,
                        inputFormController: confirmPasswordController,
                        titleColor: HexColor('#815454'),
                        borderColor: HexColor('#8154544D'),
                        focusColor: HexColor('#FEA628'),
                        //isMask: true,
                      ),
                      StreamBuilder<PassChangeCredentials>(
                        stream: changePassBloc.changePass,
                        builder: (BuildContext context, AsyncSnapshot<PassChangeCredentials> passData) {
                          return FutureBuilder<ChangePassFlowStatus?>(
                            future: changePassBloc.fetchChangePassResult(passData.data),
                            builder: (BuildContext context, AsyncSnapshot<ChangePassFlowStatus?> passResult) {
                              if (passResult.connectionState == ConnectionState.done) {
                                // Widgetの描画が完了かつstatusがtrueの時のみ遷移先判別
                                WidgetsBinding.instance!.addPostFrameCallback((_) {
                                  if (pushButton == true) {
                                    switch (passResult.data) {
                                      // パスワード変更成功
                                      case ChangePassFlowStatus.success:
                                        Navigator.of(context).pushReplacementNamed('/top');
                                        break;
                                      // パスワード変更失敗(入力ミス)
                                      case ChangePassFlowStatus.fail:
                                        showDialog<int>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return IOSStyleDialog(
                                              titleText: '入力されたパスワードが一致していません。',
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
                                return Column(
                                  children: <Widget>[
                                    FixedText(
                                      text: r'パスワードは英数字(大文字を含む)の組み合わせで8文字以上必要です。',
                                      size: 12,
                                      color: passResult.data == ChangePassFlowStatus.reg_error ? HexColor('#FC3333') : HexColor('#00000080'),
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      weight: passResult.data == ChangePassFlowStatus.reg_error ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ProgressButton(
                                      text: 'パスワード設定',
                                      textSize: 18,
                                      height: 48,
                                      width: displayWidth - 40,
                                      btnColor: HexColor('#000000'),
                                      textColor: HexColor('#FFFFFF'),
                                      onPressed: () {
                                        // 遷移先判別を行うために"true"へ変更
                                        pushButton = true;
                                        FocusScope.of(context).unfocus();

                                        final String oldPass = oldPasswordController.text.trim();
                                        final String newPass = newPasswordController.text.trim();
                                        final String confirmPass = confirmPasswordController.text.trim();
                                        changePassBloc.changeAction.add(PassChangeCredentials(
                                          oldPass: oldPass,
                                          newPass: newPass,
                                          confirmPass: confirmPass,
                                        ));
                                      },
                                    ),
                                  ],
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
