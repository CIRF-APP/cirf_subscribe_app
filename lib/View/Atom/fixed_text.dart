import 'package:flutter/material.dart';

class FixedText extends StatelessWidget {//自動調整なし、指定したサイズで固定して描画
  const FixedText({
    required this.text,//表示する文字列
    this.maxLines = 1,//最大何行まで描画するか
    this.color = Colors.black,//テキストの色
    required this.size,//テキストのサイズ
    this.weight = FontWeight.normal,//fontのweight（ボールド体＝太字にするやつ、イタリック体＝文字を斜めにするやつ）normalは普通のやつ
    this.lineHeight = 0.0, //テキストの高さを使用するパラメータ（日本語と英語で同じフォントサイズでも高さが違うことがある、それを調整する）、0で指定するとフォントのサイズと同じ
    this.textAlign = TextAlign.center,//テキストの揃え位置
  });

  final String text;
  final int maxLines;
  final Color color;
  final double size;
  final FontWeight weight;
  final double lineHeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {//UIの表示を行う関数
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
