import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/View/Molecule/page_app_bar.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);

    return PageAppBar(
      pageTitle: 'CIRF',
      body: FutureBuilder<void>(
        future: audioDatabaseBloc.fetchAudioData(),
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
