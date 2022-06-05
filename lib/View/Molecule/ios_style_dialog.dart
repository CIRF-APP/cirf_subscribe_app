import 'package:cirf_subscription_app/Model/exception_behavior_model.dart';
import 'package:cirf_subscription_app/View/Atom/fit_text.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// アイコンとテキストを並べて表示するためのウィジェット
// 必須要素：タイトルテキスト、メッセージテキスト、ボタン1タップ時の動作、ボタン1の名前、ボタン2タップ時の動作、ボタン2の名前
// 任意要素：タイトルテキストのサイズ,ウェイト,色、メッセージテキストのサイズ,ウェイト,色、ボタンのテキストの色
class IOSStyleDialog extends StatelessWidget {
  const IOSStyleDialog({
    required this.titleText,
    this.titleTextSize = 18,
    this.titleTextWeight = FontWeight.bold,
    this.titleTextColor = Colors.black,
    this.messageText = '',
    this.messageTextSize = 15,
    this.messageTextWeight = FontWeight.normal,
    this.messageTextColor = Colors.black,
    required this.onPressButton1,
    required this.button1Text,
    this.onPressButton2,
    this.button2Text = '',
    this.leftTextColor = Colors.blue,
    this.rightTextColor = Colors.blue,
  });

  factory IOSStyleDialog.fromModel(ExceptionBehaviorModel model) {
    return IOSStyleDialog(
      titleText: model.title,
      messageText: model.message,
      onPressButton1: model.button1Tap,
      button1Text: model.button1Text,
      onPressButton2: model.button2Tap,
      button2Text: model.button2Text,
    );
  }

  // ダイアログのタイトル
  final String titleText;
  final double titleTextSize;
  final FontWeight titleTextWeight;
  final Color titleTextColor;

  // ダイアログのメッセージ
  final String messageText;
  final double messageTextSize;
  final FontWeight messageTextWeight;
  final Color messageTextColor;

  // ボタンのアクション設定
  final void Function() onPressButton1;
  final String button1Text;
  final void Function()? onPressButton2;
  final String? button2Text;
  final Color leftTextColor;
  final Color rightTextColor;

  @override
  Widget build(BuildContext context) {
    // ボタンが押された時の挙動
    final List<Widget> buttonActions = <Widget>[
      CupertinoDialogAction(
        child: FixedText(
          text: button1Text,
          size: 18,
          color: leftTextColor,
        ),
        onPressed: onPressButton1,
      )
    ];

    // 2つ目のボタンが引数て設定された場合
    if (onPressButton2 != null) {
      buttonActions.add(CupertinoDialogAction(
        child: FixedText(
          text: button2Text!,
          size: 18,
          weight: FontWeight.bold,
          color: rightTextColor,
        ),
        onPressed: onPressButton2,
      ));
    }

    return CupertinoAlertDialog(
      // ダイアログでFitTextを使用するとエラーになる
      // 高さを指定したSizedBoxで囲むことでエラーを回避できる
      title: SizedBox(
        height: 30,
        child: FitText(
          text: titleText,
          size: titleTextSize,
          weight: titleTextWeight,
          color: titleTextColor,
        ),
      ),
      content: FixedText(
        text: messageText,
        size: messageTextSize,
        weight: messageTextWeight,
        color: messageTextColor,
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
      actions: buttonActions,
    );
  }
}
