import 'package:cigarandcoffee/Bloc/play_button_bloc.dart';
import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/Page/top_page.dart';
import 'View/Page/VideoPlayer_Page.dart';

void main() {
  runApp(const CirfApp());
}

class CirfApp extends StatelessWidget {
  const CirfApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
          // 画面名「/videoplayer」トップ画面
          '/videoplayer': (BuildContext context) => const VideoPlayerPage(),
        },
        // Blocパターン用
        home: const TopPage(),
      ),
    );
  }
}

