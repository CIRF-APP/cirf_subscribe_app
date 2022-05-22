import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Bloc/confirm_password_bloc.dart';
import 'package:cirf_subscription_app/Bloc/login_bloc.dart';
import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/View/Page/change_pass_page.dart';
import 'package:cirf_subscription_app/View/Page/search_result_page.dart';
import 'package:cirf_subscription_app/View/Page/sign_up_page.dart';
import 'package:cirf_subscription_app/View/Page/top_page.dart';
import 'package:cirf_subscription_app/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'Bloc/sign_up_bloc.dart';
import 'View/Page/first_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await configureAmplify();
  runApp(const CirfApp());
}

Future<void> configureAmplify() async {
  final AmplifyClass amplify = Amplify;
  try {
    await amplify.addPlugins(<AmplifyPluginInterface>[
      AmplifyAuthCognito(),
    ]);
    await amplify.configure(amplifyconfig);
  } catch(e){
    print(e.toString());
  }
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
        Provider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
          dispose: (BuildContext context, LoginBloc bloc) => bloc.dispose(),
        ),
        Provider<ConfirmPasswordBloc>(
          create: (BuildContext context) => ConfirmPasswordBloc(),
          dispose: (BuildContext context, ConfirmPasswordBloc bloc) => bloc.dispose(),
        ),
        Provider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(),
          dispose: (BuildContext context, SignUpBloc bloc) => bloc.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // 画面遷移用
        routes: <String, WidgetBuilder>{
          // 画面名「/pass_change」
          '/pass_change': (BuildContext context) => const ChangePassPage(),
          // 画面名「/top」トップ画面
          '/top': (BuildContext context) => const TopPage(),
          // 画面名「/search_res」検索結果画面
          '/search_res': (BuildContext context) => const SearchResultPage(),
          // 画面名「/sign_up」サインアップページ
          '/sign_up': (BuildContext context) => const SignUpPage(),
          // 画面名「/verification」サインアップページ
          '/verification': (BuildContext context) => const SignUpPage(),
        },
        // Blocパターン用
        home: const FirstPage(),
      ),
    );
  }
}

