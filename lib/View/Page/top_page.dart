import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Common/exception_behavior.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/ios_style_dialog.dart';
import 'package:cirf_subscription_app/View/Organism/ads_banner_widget.dart';
import 'package:cirf_subscription_app/View/Organism/other_music_list.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const FixedText(
          text: 'CIRF',
          size: 20,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/search_res');
            },
            icon: SimpleIcon(
              icon: Icons.search,
              color: HexColor('#000000'),
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
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const ScrollList(title: 'おすすめ'),
                        const SizedBox(height: 30),
                        const OtherMusicList(),
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
      bottomNavigationBar: const AdsBannerWidget(),
    );
  }
}
