// 例外ダイアログの表示・動作で使用するデータのモデル
// 必須：ダイアログタイトル、ダイアログ本文、ボタン1(左側)タップ時の処理、ボタン1(左側)のテキスト、ボタン2(右側)タップ時の処理、ボタン2(右側)のテキスト

class ExceptionBehaviorModel {
  ExceptionBehaviorModel({
    required this.title,
    required this.message,
    required this.button1Tap,
    required this.button1Text,
    required this.button2Tap,
    required this.button2Text,
  });

  final String title;
  final String message;
  final void Function() button1Tap;
  final String button1Text;
  final void Function()? button2Tap;
  final String button2Text;
}
