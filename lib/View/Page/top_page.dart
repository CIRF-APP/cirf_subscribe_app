import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/page_app_bar.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);
    final TextEditingController searchController = TextEditingController();

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
          controller: searchController,
        ),
      ),
      leftButton: IconButton(
        onPressed: () {},
        icon: SimpleIcon(
          icon: Icons.menu,
          color: HexColor('#000000'),
        ),
      ),
      rightButton: IconButton(
        onPressed: () {
          audioDatabaseBloc.searchMusic.add(searchController.text);
          Navigator.of(context).pushNamed('/search_res');
        },
        icon: SimpleIcon(
          icon: Icons.search,
          color: HexColor('#000000'),
        ),
      ),
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
