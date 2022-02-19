import 'package:cigarandcoffee/Common/hex_color.dart';
import 'package:cigarandcoffee/View/Atom/FixedText.dart';
import 'package:cigarandcoffee/View/Molecule/main_app_bar.dart';
import 'package:cigarandcoffee/View/Organism/seek_bar.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({
    required this.musicTitle,
  });

  final String musicTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {}, //この中にハンバーガーメニューを表示するのを書く
          icon: Icon(
            Icons.arrow_downward, //横棒三本
            color: HexColor('#000000'),
          ),
        ),
      ),
      body: Container(
        color: Colors.redAccent,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //SizedBox(height: 30),
            Image.asset('assets/images/image1.png'),
            FixedText(
              text: musicTitle,
              size: 24,
              weight: FontWeight.bold,
            ),
            SeekBar(),
          ],
        ),
      ),
    );
  }
}
