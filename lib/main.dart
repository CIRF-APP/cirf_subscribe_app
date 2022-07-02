import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/View/Page/search_result_page.dart';
import 'package:cirf_subscription_app/View/Page/top_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'Common/ad_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<InitializationStatus> initFuture = MobileAds.instance.initialize();
  final AdState adState = AdState(initFuture);
  await Hive.initFlutter();
  runApp(Provider<AdState>.value(
    value: adState,
    builder: (BuildContext context, Widget? child) => const CirfApp(),
  ));
}

class CirfApp extends StatelessWidget {
  const CirfApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AudioDatabaseBloc>(
          create: (BuildContext context) => AudioDatabaseBloc(),
          dispose: (BuildContext context, AudioDatabaseBloc bloc) => bloc.dispose(),
        ),
        Provider<MusicControlBloc>(
          create: (BuildContext context) => MusicControlBloc(),
          dispose: (BuildContext context, MusicControlBloc bloc) => bloc.dispose(),
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

