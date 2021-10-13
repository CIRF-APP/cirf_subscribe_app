import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/FixedText.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

import 'hamburger_menu.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({
    required this.body,
    required this.rightOnPressed,
    required this.leftImage,
    required this.rightImage,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
    this.titleFontSize = 24,
    this.subTitleFontSize = 12,
  });

  final Widget body;
  final VoidCallback rightOnPressed;
  final String rightImage;
  final Icon leftImage;
  final Color backColor;
  final Color textColor;
  final double titleFontSize;
  final double subTitleFontSize;

  // ハンバーガーメニューを閉じるため、Scaffoldにキーを設定しておく
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FixedText(
              text: '',
              size: titleFontSize,
              color: textColor,
              lineHeight: 1.0,
            ),
            FixedText(
              text: 'さん',
              size: subTitleFontSize,
              color: textColor,
              lineHeight: 3.0,
            ),
          ],
        ),
        backgroundColor: backColor,
        centerTitle: true,
        // TODO(you): ユーザ画像(menuボタン)の取得方法→内部DBから取得予定
        leading: IconButton(
          icon: leftImage,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          // TODO(you): 「在宅中ラベル」仕様決定/作成完了時に追加
          ElevatedButton(
            onPressed: rightOnPressed,
            style: ElevatedButton.styleFrom(
              primary: HexColor('#FFA61C'), // background
              elevation: 0, // foreground
            ),
            child: Image.asset(
              rightImage,
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
      drawer: HamburgerMenu(
        targetName: '',
        // TODO(YOU): APIから電話番号取得・ハイフン追加処理
        targetTel: '',
        // TODO(you): ユーザー画像の取得方法・仕様決定後に変更
        targetIcon: SimpleIcon(
          icon: const Icon(Icons.account_circle),
          color: HexColor('FDF3E4'),
          size: 60,
        ),
      ),
      body: body,
    );
  }
}