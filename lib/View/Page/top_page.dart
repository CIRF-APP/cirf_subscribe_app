import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Common/exception_behavior.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/Model/music_status_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/ios_style_dialog.dart';
import 'package:cirf_subscription_app/View/Organism/ads_banner_widget.dart';
import 'package:cirf_subscription_app/View/Organism/other_music_list.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:cirf_subscription_app/View/Organism/smallest_music.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);
    final MusicControlBloc musicControlBloc = Provider.of<MusicControlBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const FixedText(
          text: 'CIRF',
          size: 20,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/search_res');
            },
            icon: const SimpleIcon(
              icon: Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<void>(
        initialData: false,
        stream: audioDatabaseBloc.rebuildStream,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return FutureBuilder<int>(
            future: audioDatabaseBloc.fetchAudioData(),
            builder: (BuildContext context, AsyncSnapshot<int> httpStatus) {
              if (httpStatus.connectionState == ConnectionState.done) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (httpStatus.data != 200) {
                    showDialog<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return IOSStyleDialog.fromModel(getBehavior(
                          httpStatus.data,
                          context,
                          audioDatabaseBloc,
                        ));
                      },
                    );
                  }
                });

                return Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const ScrollList(title: 'おすすめ'),
                        const SizedBox(height: 30),
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
          );
        },
      ),
      //bottomNavigationBar: const AdsBannerWidget(),
      bottomSheet: StreamBuilder<MusicStatusModel>(
        initialData: MusicStatusModel(
          status: MusicPageStatus.disabled,
          model: MusicModel.emptyModel(),
        ),
        stream: musicControlBloc.musicPage,
        builder: (BuildContext context, AsyncSnapshot<MusicStatusModel> musicStatus) {
          print(musicStatus.data?.status);
          return musicStatus.data?.status == MusicPageStatus.smallest ? SmallestMusic(musicData: musicStatus.data?.model ?? MusicModel.emptyModel()) : Container(height: 0);
        },
      ),
    );
  }
}
