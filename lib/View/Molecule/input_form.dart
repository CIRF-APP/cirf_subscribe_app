import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:flutter/material.dart';

// 入力フォームウィジェット
// 必須要素：入力フォームタイトル、入力値のコントローラー
// 任意要素：タイトル文字サイズ、タイトル文字色、下線色(非選択時)、下線色(選択時)、マスク処理の有無、表示するキーボードの種類
class InputForm extends StatelessWidget {
  const InputForm({
    required this.title,
    this.onChange,
    this.inputFormController,
    this.titleSize = 16,
    this.titleColor = Colors.white,
    this.borderColor = Colors.black,
    this.focusColor = Colors.blue,
    this.isMask = false,
    this.hintText = '',
    this.hintColor = Colors.black,
    this.hintSize = 16,
    this.type = TextInputType.emailAddress,
  });

  final String title;
  final TextEditingController? inputFormController;
  final double titleSize;
  final Color titleColor;
  final Color borderColor;
  final Color focusColor;
  final bool isMask;
  final String hintText;
  final Color hintColor;
  final double hintSize;

  final void Function(String)? onChange;
  //final void Function(String) onChange;

  // 選択可能なキーボードタイプは以下を参照
  // https://api.flutter.dev/flutter/services/TextInputType-class.html
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FixedText(
          text: title,
          size: titleSize,
          color: titleColor,
          weight: FontWeight.bold,
        ),
        TextField(
          controller: inputFormController,
          obscureText: isMask,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: hintSize, color: hintColor),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: focusColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
