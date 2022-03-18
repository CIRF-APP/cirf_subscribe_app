import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Bloc/play_button_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Page/search_result_page.dart';
import 'package:cirf_subscription_app/View/Page/top_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MusicModelAdapter());
  runApp(const CirfApp());
}

class CirfApp extends StatelessWidget {
  const CirfApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_type
      providers: [
        Provider<AudioDatabaseBloc>(
          create: (BuildContext context) => AudioDatabaseBloc(),
          dispose: (BuildContext context, AudioDatabaseBloc bloc) => bloc.dispose(),
        ),
        Provider<PlayButtonBloc>(
          create: (BuildContext context) => PlayButtonBloc(),
          dispose: (BuildContext context, PlayButtonBloc bloc) => bloc.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // 画面遷移用
        routes: <String, WidgetBuilder>{
          // 画面名「/top」トップ画面
          '/top': (BuildContext context) => const TopPage(),
          // 画面名「/search_res」検索結果画面
          '/search_res': (BuildContext context) => const SearchResultPage(),
        },
        // Blocパターン用
        home: const TopPage(),
      ),
    );
  }
}

