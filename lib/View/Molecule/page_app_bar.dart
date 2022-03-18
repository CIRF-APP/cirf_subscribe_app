import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageAppBar extends StatelessWidget {
  PageAppBar({
    required this.title,
    required this.leftButton,
    required this.rightButton,
    required this.body,
    this.backColor = Colors.white,
  });

  final Widget body;
  final Widget title;
  final Widget leftButton;
  final Widget rightButton;
  final Color backColor;

  // ハンバーガーメニューを閉じるため、Scaffoldにキーを設定しておく
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final AudioDatabaseBloc bloc = Provider.of<AudioDatabaseBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: title,
        backgroundColor: backColor,
        centerTitle: true,
        leading: leftButton,
        actions: <Widget>[
          rightButton,
        ],
      ),
      body: body,
    );
  }
}
