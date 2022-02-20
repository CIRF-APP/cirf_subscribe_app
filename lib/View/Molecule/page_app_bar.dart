import 'package:cigarandcoffee/Common/hex_color.dart';
import 'package:cigarandcoffee/View/Atom/fixed_text.dart';
import 'package:cigarandcoffee/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  PageAppBar({
    required this.pageTitle,
    this.titleFontSize = 20,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
    required this.body,
  });

  final Widget body;
  final Color backColor;
  final String pageTitle;
  final double titleFontSize;
  final Color textColor;

  // ハンバーガーメニューを閉じるため、Scaffoldにキーを設定しておく
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: FixedText(
          text: pageTitle,
          size: titleFontSize,
          color: textColor,
        ),
        backgroundColor: backColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: SimpleIcon(
            icon: Icons.menu,
            color: HexColor('#000000'),
          ),
        ),
        actions: <Widget>[//actionsが基本的に右、配列だから複数指定できる
          IconButton(
            onPressed: () {},
            icon: SimpleIcon(
              icon: Icons.search,
              color: HexColor('#000000'),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
