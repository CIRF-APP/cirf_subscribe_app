import 'package:cigarandcoffee/View/Atom/FixedText.dart';
import 'package:cigarandcoffee/View/Molecule/main_app_bar.dart';
import 'package:cigarandcoffee/View/Molecule/music_card.dart';
import 'package:flutter/material.dart';

class ScrollList extends StatelessWidget {
  const ScrollList({
    this.title1 = '再生中',
    this.title2 = 'おすすめ',
    this.title3 = '作品一覧',
  });

  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 320, //960,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FixedText(
                  text: title1,
                  size: 24,
                  weight: FontWeight.bold,
                ),
                playingList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget playingList(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 5, right: 5),
      scrollDirection: Axis.horizontal,
      controller: ScrollController(),
      child: SizedBox(
        width: 900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MusicCard(
              musicName: 'bgm1',
              imageFile: 'image1.png',
            ),
            MusicCard(
              musicName: 'bgm2',
              imageFile: 'image2.png',
            ),
            MusicCard(
              musicName: 'bgm3',
              imageFile: 'image3.png',
            ),
          ],
        ),
      ),
    );
  }
}
