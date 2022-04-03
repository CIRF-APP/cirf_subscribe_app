import 'package:cirf_subscription_app/Common/global_instance.dart';
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
              children: getMusicCardList(),
            ),
          ),
        ),
      ],
    );
  }

  List<MusicCard> getMusicCardList() {
    final List<MusicCard> musicList = <MusicCard>[];
    musicList.add(MusicCard(musicData: audioDatabaseService.musicDatabase[25]));
    musicList.add(MusicCard(musicData: audioDatabaseService.musicDatabase[26]));
    musicList.add(MusicCard(musicData: audioDatabaseService.musicDatabase[27]));
    return musicList;
  }
}
