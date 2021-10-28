import 'package:cirf_subscription_app/Common/audio_controller.dart';
import 'package:cirf_subscription_app/View/Atom/FixedText.dart';
import 'package:cirf_subscription_app/View/Molecule/main_app_bar.dart';
import 'package:flutter/material.dart';

class ScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> menuTitle = <String>['あなたへのおすすめ', '視聴中の作品', 'その他'];
    return MainAppBar(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: 3,
        itemBuilder: (BuildContext context, int verticalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SizedBox(
              height: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FixedText(
                    text: menuTitle[verticalIndex],
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                  _buildHorizontalItem(context, verticalIndex),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildHorizontalItem(BuildContext context, int verticalIndex) {
    final AudioController audioController = AudioController();

    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 3,
        itemBuilder: (BuildContext context, int horizontalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: ElevatedButton(
                child: Container(
                  width: 275,
                  height: 240,
                  color: Colors.blue,
                ),
                onPressed: () {
                  if(audioController.isPlay(horizontalIndex)){
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
