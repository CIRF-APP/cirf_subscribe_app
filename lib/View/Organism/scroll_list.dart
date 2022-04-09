import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Organism/music_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollList extends StatelessWidget {
  const ScrollList({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc bloc = Provider.of<AudioDatabaseBloc>(context);
    final List<MusicCard> musicList = <MusicCard>[];

    if(bloc.service.musicDatabase.isNotEmpty){
      musicList.add(MusicCard(musicData: bloc.service.musicDatabase[25]));
      musicList.add(MusicCard(musicData: bloc.service.musicDatabase[26]));
      musicList.add(MusicCard(musicData: bloc.service.musicDatabase[27]));
    }

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
              children: musicList,
            ),
          ),
        ),
      ],
    );
  }
}
