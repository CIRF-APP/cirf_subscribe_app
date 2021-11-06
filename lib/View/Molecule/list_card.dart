import 'package:cigarandcoffee/Common/hex_color.dart';
import 'package:cigarandcoffee/View/Atom/FitText.dart';
import 'package:cigarandcoffee/View/Atom/simple_icon.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';


class ListCard extends StatelessWidget {
  const ListCard({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SimpleIcon(
              icon: const Icon(Icons.chevron_right_rounded),
              color: HexColor('#815454'),
              size: 25,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FitText(
                  text: title,
                  size: 18,
                  color: HexColor('#815454'),
                  weight: FontWeight.bold,
                  minFontSize: 14,
                ),
                SimpleIcon(
                  icon: const Icon(Icons.chevron_right_rounded),
                  color: HexColor('#815454'),
                  size: 25,
                ),
              ],
            ),
            onTap: onPressed,
          ),
          DottedLine(
            dashColor: HexColor('#CFA571'),
          )
        ],
      ),
    );
  }
}
