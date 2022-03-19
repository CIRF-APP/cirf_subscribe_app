import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/music_card.dart';
import 'package:flutter/material.dart';

class ScrollList extends StatelessWidget {
  const ScrollList({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FixedText(
          text: title,
          size: 24,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 5, right: 5),
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: SizedBox(
            width: 900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <MusicCard>[
                MusicCard(
                  musicData: MusicModel(
                    audioName: 'bgm1',
                    audioFile: 'bgm26.mp3',
                    imageFile: 'image1.png',
                  ),
                ),
                MusicCard(
                  musicData: MusicModel(
                    audioName: 'bgm2',
                    audioFile: 'bgm27.mp3',
                    imageFile: 'image2.png',
                  ),
                ),
                MusicCard(
                  musicData: MusicModel(
                    audioName: 'bgm3',
                    audioFile: 'bgm28.mp3',
                    imageFile: 'image3.png',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
