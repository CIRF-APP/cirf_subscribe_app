import 'package:cigarandcoffee/Common/audio_controller.dart';
import 'package:cigarandcoffee/View/Atom/FixedText.dart';
import 'package:cigarandcoffee/View/Molecule/main_app_bar.dart';
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
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SizedBox(
          height: 960,
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
              FixedText(
                text: title2,
                size: 24,
                weight: FontWeight.bold,
              ),
              recomList(context),
              FixedText(
                text: title3,
                size: 24,
                weight: FontWeight.bold,
              ),
              compositionList(context),
            ],
          ),
        ),
      ),
    ));
  }

  Widget playingList(BuildContext context) {
    final AudioController audioController = AudioController();
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 5,
        itemBuilder: (BuildContext context, int horizontalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 100,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  if (audioController.isPlay(horizontalIndex)) {
                    audioController.pauseAudio(horizontalIndex);
                  } else {
                    audioController.playAudio(horizontalIndex);
                  }
                },
                child: Image.asset(
                  'assets/images/image1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget recomList(BuildContext context) {
    final AudioController audioController = AudioController();
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 5,
        itemBuilder: (BuildContext context, int horizontalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: ElevatedButton(
                child: SizedBox(
                  //Container(長方形を描画)→写真に変えたい場合imageに変える
                  width: 275,
                  height: 240,
                  child: Image.asset(
                    'assets/images/image1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                onPressed: () {
                  if (audioController.isPlay(horizontalIndex)) {
                    audioController.pauseAudio(horizontalIndex);
                  } else {
                    audioController.playAudio(horizontalIndex);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget compositionList(BuildContext context) {
    final AudioController audioController = AudioController();
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 5,
        itemBuilder: (BuildContext context, int horizontalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: ElevatedButton(
                child: SizedBox(
                  width: 275,
                  height: 240,
                  child: Image.asset(
                    'assets/images/image1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                onPressed: () {
                  if (audioController.isPlay(horizontalIndex)) {
                    audioController.pauseAudio(horizontalIndex);
                  } else {
                    audioController.playAudio(horizontalIndex);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
