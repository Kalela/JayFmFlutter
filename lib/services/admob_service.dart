import 'dart:io';

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
}
