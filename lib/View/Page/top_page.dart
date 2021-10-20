import 'package:audioplayers/audioplayers.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/gradation_background.dart';
import 'package:cirf_subscription_app/View/Molecule/main_app_bar.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioCache _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );

    _cache.loadAll(['music/bgm1.mp3', 'music/bgm2.mp3', 'music/bgm3.mp3']);
    AudioPlayer? player;

    return Center(
      child: ElevatedButton(
        onPressed: () async {
          player = await _cache.play('music/bgm1.mp3');
        },
        child: Container(
          width: 275,
          height: 240,
          color: Colors.blue,
        ),
      ),
    );
    // return ScrollList();
  }
}
