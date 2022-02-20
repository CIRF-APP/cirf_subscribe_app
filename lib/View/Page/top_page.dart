import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:cigarandcoffee/View/Molecule/page_app_bar.dart';
import 'package:cigarandcoffee/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioManager audioManager = Provider.of<AudioManager>(context);

    return PageAppBar(
      pageTitle: 'CIRF',
      body: FutureBuilder<void>(
        future: audioManager.loadFiles(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const ScrollList(title: '再生中'),
                    const SizedBox(height: 30),
                    const ScrollList(title: 'おすすめ'),
                    const SizedBox(height: 30),
                    const ScrollList(title: 'その他'),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
