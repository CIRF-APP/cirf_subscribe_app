import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/Model/search_result_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/music_tile.dart';
import 'package:cirf_subscription_app/View/Molecule/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);

    audioDatabaseBloc.pageTransition.add(null);
    return PageAppBar(
      title: SizedBox(
        height: 36,
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            hintText: 'Input title',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          onChanged: (String word) {
            audioDatabaseBloc.searchMusic.add(word);
          },
        ),
      ),
      leftButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SimpleIcon(
          icon: Icons.arrow_back,
          color: HexColor('#000000'),
        ),
      ),
      body: StreamBuilder<SearchResultModel>(
        initialData: SearchResultModel.emptyModel(),
        stream: audioDatabaseBloc.searchResult,
        builder: (BuildContext context, AsyncSnapshot<SearchResultModel> searchResult) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  FixedText(
                    text: searchResult.data?.searchWord == '' ? '' : '${searchResult.data?.searchWord ?? ''}の検索結果',
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  for (MusicTile tile in convertMusicTile(searchResult.data?.resultList)) tile,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<MusicTile> convertMusicTile(List<MusicModel>? musicList) {
    if (musicList == null) {
      return <MusicTile>[];
    } else {
      final List<MusicTile> musicTiles = <MusicTile>[];
      for (final MusicModel music in musicList) {
        musicTiles.add(MusicTile(musicData: music));
      }
      return musicTiles;
    }
  }
}
