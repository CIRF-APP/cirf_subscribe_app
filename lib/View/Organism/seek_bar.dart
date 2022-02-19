import 'package:cigarandcoffee/View/Atom/FixedText.dart';
import 'package:cigarandcoffee/View/Atom/simple_circle.dart';
import 'package:cigarandcoffee/View/Molecule/play_button.dart';
import 'package:flutter/material.dart';

class SeekBar extends StatelessWidget {
  const SeekBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          height: 5,
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FixedText(
              text: '1:00',
              size: 12,
            ),
            FixedText(
              text: '4:00',
              size: 12,
            ),
          ],
        ),
        SizedBox(height: 10),
        PlayButton(musicTitle: 'bgm1'),

        /*SimpleCircle(
          radius: 30,
          color: Colors.white,
        ),*/
      ],
    );
  }
}
