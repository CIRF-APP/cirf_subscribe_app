import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsInterstitial {
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;


  void interstitialLoad() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad){
          interstitialAd = ad;
          isAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
        },
      ),
    );
  }

  Future<void> show(void Function() executor) async {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print('ad onAdshowedFullscreen');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('ad Disposed');
        ad.dispose();
        executor();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError adError) {
        print('$ad OnAdFailed $adError');
        ad.dispose();
        interstitialLoad();
      },
    );

    await interstitialAd?.show();
    interstitialAd = null;
  }
}
