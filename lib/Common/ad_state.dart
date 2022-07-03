// import 'dart:io';
//
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdState {
//   AdState(this.initialization);
//
//   Future<InitializationStatus> initialization;
//   String get bannerAdUnitId => Platform.isAndroid ? 'ca-app-pub-6605960894275308/9637723196' : 'ca-app-pub-6605960894275308/2046462616';
//
//   BannerAdListener get adListener => _adListener;
//
//   final BannerAdListener _adListener = BannerAdListener(
//     onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
//     onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
//     onAdFailedToLoad: (Ad ad, LoadAdError error) => print('Ad failed to load: ${ad.adUnitId}, $error.'),
//     onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
//     onAdClicked: (Ad ad) => print('Ad clicked: ${ad.adUnitId}.'),
//     onAdImpression: (Ad ad) => print('Ad impression: ${ad.adUnitId}.'),
//     onPaidEvent: (Ad ad, double v, PrecisionType type, String str) => print('Ad paid event: ${ad.adUnitId}.'),
//     onAdWillDismissScreen: (Ad ad) => print('Ad WillDismiss: ${ad.adUnitId}.'),
//   );
//
//   /*AdListener get adListener => _adListener;
//   final AdListener _adListener = AdListener(
//     onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
//     onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
//     onAdFailedToLoad: (Ad ad, LoadAdError error) => print('Ad failed to load: ${ad.adUnitId}, $error.'),
//     onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
//     onAppEvent: (Ad ad, String name, String data) => print('App event: ${ad.adUnitId}, $name, $data'),
//     onApplicationExit: (Ad ad) => print('App Exit: ${ad.adUnitId}.'),
//     onNativeAdClicked: (NativeAd nativeAd) => print('Native ad clicked: ${nativeAd.adUnitId}'),
//     onNativeAdImpression: (NativeAd nativeAd) => print('Native ad impression: ${nativeAd.adUnitId}'),
//     onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) =>
//         print('User rewarded: ${ad.adUnitId}, ${reward.amount} ${reward.type}.'),
//   );*/
// }