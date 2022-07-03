import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsBannerWidget extends StatefulWidget {
  const AdsBannerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdWidgetState();
  }
}

class _AdWidgetState extends State<AdsBannerWidget> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', //Platform.isAndroid ? 'ca-app-pub-6605960894275308/9637723196' : 'ca-app-pub-6605960894275308/2046462616',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) => print('Ad failed to load: ${ad.adUnitId}, $error.'),
        onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
        onAdClicked: (Ad ad) => print('Ad clicked: ${ad.adUnitId}.'),
        onAdImpression: (Ad ad) => print('Ad impression: ${ad.adUnitId}.'),
        onPaidEvent: (Ad ad, double v, PrecisionType type, String str) => print('Ad paid event: ${ad.adUnitId}.'),
        onAdWillDismissScreen: (Ad ad) => print('Ad WillDismiss: ${ad.adUnitId}.'),
      ),
    );

    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return isAdLoaded
        ? Container(
            color: Colors.white,
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          )
        : Container();
  }
}
