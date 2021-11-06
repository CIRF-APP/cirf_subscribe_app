import 'package:cigarandcoffee/Common/audio_controller.dart';
import 'package:cigarandcoffee/View/Atom/FixedText.dart';
import 'package:cigarandcoffee/View/Molecule/main_app_bar.dart';
import 'package:flutter/material.dart';

class ScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> menuTitle = <String>['理念', 'ビジョン', '戦略' ,'将の心得', '戦術' ];
    return MainAppBar(
      body: ListView.builder(//ListView.builder
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: 5,
        itemBuilder: (BuildContext context, int verticalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SizedBox(
              height: 320,//320
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FixedText(
                    text: menuTitle[verticalIndex],
                    size: 24,//24
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
      height: 240,//240
      //width: 320,
      child: PageView.builder(//今はPageView.blulder→moleculeでボタン5つ並べる
        controller: PageController(viewportFraction: 0.8),//pagecontrollerサイズ指定？
        itemCount: 5,//3
        itemBuilder: (BuildContext context, int horizontalIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: ElevatedButton(
                child: SizedBox(//Container(長方形を描画)→写真に変えたい場合imageに変える
                  width: 275,//275
                  height: 240,//240
                  child: Image.asset('images/jon2.png'),
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
