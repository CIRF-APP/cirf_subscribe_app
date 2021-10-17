import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/FixedText.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

import 'hamburger_menu.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({
    required this.body,
    //required this.rightOnPressed,
    //required this.leftImage,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
    this.titleFontSize = 20,
  });

  final Widget body;
  //final VoidCallback rightOnPressed;
  //final Icon leftImage;
  final Color backColor;
  final Color textColor;
  final double titleFontSize;

  // ハンバーガーメニューを閉じるため、Scaffoldにキーを設定しておく
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: FixedText(
          text: 'お金呉像の集金マシーン',
          size: titleFontSize,
          color: textColor,
        ),
        backgroundColor: backColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.hail,
            color: HexColor('#000000'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: HexColor('#000000'),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
