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
                  Text(
                    menuTitle[verticalIndex],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 6,
        itemBuilder: (context, horizontalIndex) {
          final imageUrl =
              'https://source.unsplash.com/random/275x240?sig=$verticalIndex$horizontalIndex';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: Image.network(imageUrl),
            ),
          );
        },
      ),
    );
  }
}
