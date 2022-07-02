import 'package:cirf_subscription_app/Common/ad_state.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AdsBannerWidget extends StatefulWidget {
  const AdsBannerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdWidgetState();
  }
}

class _AdWidgetState extends State<AdWidget> {
  late BannerAd banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AdState adState = Provider.of<AdState>(context);
    adState.initialization.then((InitializationStatus status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: AdWidget(ad: banner),
    );
  }
}