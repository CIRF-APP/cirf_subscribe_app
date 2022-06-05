import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:flutter/material.dart';

// ページ遷移buttonウィジェット
// 必須要素：テキスト、ボタン押下時の処理、テキストサイズ、ボタン横幅、ボタン縦幅
// 任意要素：フォントカラー、ボタンカラー

class ProgressButton extends StatelessWidget {
  const ProgressButton({
    required this.text,
    required this.onPressed,
    required this.textSize,
    required this.width,
    required this.height,
    this.textColor = Colors.black,
    this.btnColor = Colors.black,
  });

  final String text;
  final VoidCallback? onPressed;
  final double textSize;
  final double width;
  final double height;
  final Color textColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: FixedText(
          text: text,
          size: textSize,
          color: textColor,
          weight: FontWeight.bold,
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(10),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black54),
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return states.contains(MaterialState.disabled) ? HexColor('#DDDDDD') : btnColor;
          }),
          shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
