import 'package:flutter/material.dart';

class SeekBar extends StatelessWidget {
  const SeekBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            height: 5,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
