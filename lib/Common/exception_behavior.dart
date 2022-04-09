import 'package:cirf_subscription_app/Bloc/api_rebuild_bloc.dart';
import 'package:cirf_subscription_app/Model/exception_behavior_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

ExceptionBehaviorModel getBehavior(int? httpStatus, BuildContext context, APIRebuildBloc bloc) {
  final int status = httpStatus ?? -1;
  return ExceptionBehaviorModel(
    title: _getExceptionTitle(status),
    message: _getExceptionMessage(status),
    button1Tap: _getButton1TapBehavior(status, context),
    button1Text: _getButton1Text(status),
    button2Tap: _getButton2TapBehavior(status, context, bloc),
    button2Text: _getButton2Text(status),
  );
}

String _getExceptionTitle(int status) {
  if (status == 400) {
    return 'データ取得エラー';
  } else if (status == 401) {
    return '認証に失敗しました';
  } else if (status == 408) {
    return 'タイムアウトしました';
  } else if (status == 503) {
    return 'アクセスが集中しています';
  } else if (400 <= status && status <= 599) {
    return '通信エラー';
  } else {
    return '不明なエラー';
  }
}

String _getExceptionMessage(int status) {
  final String errorCode = '\n(エラーコード：#$status)';
  if (status == 400) {
    return 'アプリを再起動してください$errorCode';
  } else if (status == 401) {
    return '再度ログインをお願いします$errorCode';
  } else if (status == 408) {
    return '通信環境の良い場所で再度接続をお願いします$errorCode';
  } else if (400 <= status && status <= 499) {
    return 'サポートセンターへ問い合わせをお願いします$errorCode';
  } else if (500 <= status && status <= 599) {
    return '時間をおいて再度接続をお願いします$errorCode';
  } else {
    return 'アプリを再起動してください$errorCode';
  }
}

void Function() _getButton1TapBehavior(int status, BuildContext context) {
  // 401時はログイン画面へ遷移
  // TODO(you): ログイン画面がまだ無いので活動ログページで代用
  if (status == 401) {
    return () {
      Navigator.pop(context);
      Navigator.of(context).pushNamed('/activity_log');
    };
  } else {
    return () {
      Navigator.pop(context);
    };
  }
}

String _getButton1Text(int status) {
  if ((400 <= status && status <= 499) && (status != 400 && status != 401)) {
    return '閉じる';
  } else {
    return 'OK';
  }
}

void Function()? _getButton2TapBehavior(int status, BuildContext context, APIRebuildBloc bloc) {
  // 408で再接続がタップされた時は再接続を行う
  if (status == 408) {
    return () {
      Navigator.pop(context);
      bloc.toRebuild.add(true);
    };
  }
  // 400番台(400, 401, 408を除く)はブラウザを立ち上げて問い合わせページへ遷移
  // TODO(you): 問い合わせページが無いのでGoogleトップページで代用
  else if ((400 <= status && status <= 499) && (status != 400 && status != 401)) {
    return () {
      Navigator.pop(context);
      launch('https://www.google.com');
    };
  } else {
    return null;
  }
}

String _getButton2Text(int status) {
  if (status == 408) {
    return '再接続';
  } else if ((400 <= status && status <= 499) && (status != 400 && status != 401)) {
    return '問い合わせ';
  } else {
    return '';
  }
}
