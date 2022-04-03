import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Page/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final MusicControlBloc bloc = Provider.of<MusicControlBloc>(context);

    return SizedBox(
      width: 275,
      height: 240,
      child: ElevatedButton(
        onPressed: () {
          bloc.setMusicData.add(musicData);
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder<void>(
                future: bloc.playAudio(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot){
                  if(snapshot.connectionState == ConnectionState.done) {
                    return MusicPage(musicData: musicData);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          );
        },
        child: SizedBox(
          width: 275,
          height: 240,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('assets/images/${musicData.imageFile}'),
          ),
        ),
      ),
    );
  }
}
