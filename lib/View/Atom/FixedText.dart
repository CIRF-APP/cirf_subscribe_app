import 'package:flutter/material.dart';

class FixedText extends StatelessWidget {
  const FixedText({
    required this.text,
    this.maxLines = 1,
    this.color = Colors.black,
    required this.size,
    this.weight = FontWeight.normal,
    this.lineHeight = 0.0,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final int maxLines;
  final Color color;
  final double size;
  final FontWeight weight;
  final double lineHeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
      strutStyle: StrutStyle(
        fontSize: size,
        height: lineHeight,
      ),
      textScaleFactor: 1.0,
      textAlign: textAlign,
    );
  }
}
