import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  PageAppBar({
    required this.title,
    required this.leftButton,
    this.rightButton,
    required this.body,
    this.backColor = Colors.white,
  });

  final Widget body;
  final Widget title;
  final Widget leftButton;
  final Widget? rightButton;
  final Color backColor;

  // ハンバーガーメニューを閉じるため、Scaffoldにキーを設定しておく
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: title,
        backgroundColor: backColor,
        centerTitle: true,
        leading: leftButton,
        actions: rightButton == null ? null : <Widget>[
          rightButton!,
        ],
      ),
      body: body,
    );
  }
}
