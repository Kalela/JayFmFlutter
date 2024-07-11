import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  //TODO: Return ios versions too

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7959819939331906~9989208530";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String getbannerAdUnitId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-7959819939331906/3731239177";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  BannerAd getBannerAd(BuildContext context) {
    return BannerAd(
      adUnitId: AdMobService.getbannerAdUnitId(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }
}
