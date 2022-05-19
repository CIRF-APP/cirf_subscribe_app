import 'package:cirf_subscription_app/Bloc/login_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/View/Page/top_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String environment = String.fromEnvironment('BUILD_ENV');
    final LoginBloc loginBloc = Provider.of<LoginBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<AuthFlowStatus>(
        future: loginBloc.fetchSession(),
        builder: (BuildContext context, AsyncSnapshot<AuthFlowStatus> sessionData) {
          return checkProgressPage(sessionData);
        },
      )
    );
  }

  // 遷移先ページの判別
  Widget checkProgressPage(AsyncSnapshot<AuthFlowStatus> sessionData) {
    if (sessionData.connectionState == ConnectionState.done) {
      // アプリ起動時の初期表示画面判別
      // セッション有：TopPage()
      // セッション無：LoginPage()
      switch (sessionData.data) {
        case AuthFlowStatus.success:
          return const LoginPage(); // const TopPage();

        case AuthFlowStatus.error:
          return const LoginPage();

        case AuthFlowStatus.fail:
          return const LoginPage();

        default:
          return const LoginPage();
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
