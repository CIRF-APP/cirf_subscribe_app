import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState(this.initialization);

  Future<InitializationStatus> initialization;
  String get bannerAdUnitId => Platform.isAndroid ? 'ca-app-pub-6605960894275308~6398699224' : 'ca-app-pub-1932855704444059~4895152155';

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) => print('Ad failed to load: ${ad.adUnitId}, $error.'),
    onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
    onAdClicked: (Ad ad) => print('Ad clicked: ${ad.adUnitId}.'),
    onAdImpression: (Ad ad) => print('Ad impression: ${ad.adUnitId}.'),
    onPaidEvent: (Ad ad, double v, PrecisionType type, String str) => print('Ad paid event: ${ad.adUnitId}.'),
    onAdWillDismissScreen: (Ad ad) => print('Ad WillDismiss: ${ad.adUnitId}.'),
  );
}