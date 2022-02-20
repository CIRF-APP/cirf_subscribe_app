import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';

class FitText extends StatelessWidget {//UIに応じて自動で文字の大きさを調整してくれる
  const FitText({
    required this.text,
    this.maxLines = 1,
    this.color = Colors.black,
    required this.size,
    this.weight = FontWeight.normal,
    this.lineHeight = 0.0,
    this.minFontSize = 10.0,
  });

  final String text;
  final int maxLines;
  final Color color;
  final double size;
  final FontWeight weight;
  final double lineHeight;
  final double minFontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      minFontSize: minFontSize,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
      strutStyle: StrutStyle(
        fontSize: size,
        height: lineHeight,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
