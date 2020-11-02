import 'dart:io';

// import 'package:firebase_admob/firebase_admob.dart';

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

  // static BannerAd _homeBannerAd;

  // static BannerAd _getHomeBannerAd() {
  //   return BannerAd(adUnitId: _getbannerAdUnitId(), size: AdSize.banner);
  // }

  // static void showHomeBannerAd() {
  //   if(_homeBannerAd == null )_homeBannerAd = _getHomeBannerAd();
  //   _homeBannerAd
  //   ..load()
  //   ..show(
  //     anchorType: AnchorType.bottom, anchorOffset: 30
  //   );
  // }

  // static void hideHomeBannerAd() async {
  //   await _homeBannerAd.dispose();
  //   _homeBannerAd = null;
  // }
}
