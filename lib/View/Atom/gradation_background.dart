import 'package:flutter/material.dart';

class GradationBackGround extends StatelessWidget {//背景をグラデーション表示する
  const GradationBackGround({
    required this.topColor,
    required this.bottomColor,
    required this.child,
    this.directionBegin = FractionalOffset.topCenter,
    this.directionEnd = FractionalOffset.bottomCenter,
    this.startPoint = 0.0,
    this.endPoint = 1.0,
  });

  final Color topColor;
  final Color bottomColor;
  final Widget child;
  final FractionalOffset directionBegin;
  final FractionalOffset directionEnd;
  final double startPoint;
  final double endPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // グラデーションの向きの指定
          begin: directionBegin,
          end: directionEnd,
          // グラデーションの開始色と終了色の指定
          colors: <Color>[
            topColor,
            bottomColor,
          ],
          // グラデーションの開始位置と終了位置を指定
          stops: <double>[
            startPoint,
            endPoint,
          ],
        ),
      ),
      child: child,
    );
  }
}
