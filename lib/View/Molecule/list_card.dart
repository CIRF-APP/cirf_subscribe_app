import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/fit_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';


class ListCard extends StatelessWidget {
  const ListCard({
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SimpleIcon(
                  icon: icon,
                  color: HexColor('#815454'),
                  size: 25,
                ),
                const SizedBox(
                  width: 40,
                ),
                FitText(
                  text: title,
                  size: 18,
                  color: HexColor('#815454'),
                  weight: FontWeight.bold,
                  minFontSize: 14,
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
