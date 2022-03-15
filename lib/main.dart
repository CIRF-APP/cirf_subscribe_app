import 'package:cigarandcoffee/Bloc/play_button_bloc.dart';
import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Common/csv_reader.dart';
import 'Model/music_model.dart';
import 'View/Page/top_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MusicModelAdapter());
  ReadCSVFile();
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
        Provider<AudioManager>(
          create: (BuildContext context) => AudioManager(),
          dispose: (BuildContext context, AudioManager audioManager) => audioManager.close(),
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
        },
        // Blocパターン用
        home: const TopPage(),
      ),
    );
  }
}

