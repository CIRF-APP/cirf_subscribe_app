import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  const PageAppBar({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
