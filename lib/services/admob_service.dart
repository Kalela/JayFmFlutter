import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';

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

  AdmobBanner getBannerAd(BuildContext context) {
    return AdmobBanner(
        adUnitId: AdMobService.getbannerAdUnitId(),
        adSize: AdmobBannerSize.SMART_BANNER(context));
  }
}
