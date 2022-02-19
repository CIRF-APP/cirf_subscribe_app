import 'package:cigarandcoffee/View/Organism/scroll_list.dart';
import 'package:cigarandcoffee/View/Page/music_page.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MusicPage(musicTitle: 'bgm1'); // ScrollList();
  }
}
