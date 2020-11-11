import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality = PodcastQuality.MED;
  Widget bannerAd;
  SharedPreferences sharedPreferences;
  dynamic nowPlaying;

  GlobalAppColors colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white);

  AppState({this.selectedTheme, this.bannerAd, this.sharedPreferences, this.podcastQuality}){
    if (selectedTheme == SelectedTheme.DARK) {
      colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white);
    } else {
      colors = GlobalAppColors(
          mainBackgroundColor: jayFmBlue,
          mainButtonsColor: jayFmFancyBlack,
          mainIconsColor: jayFmOrange,
          mainTextColor: Colors.black);
    }
  }

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
    podcastQuality = another.podcastQuality;
    bannerAd = another.bannerAd;
    sharedPreferences = another.sharedPreferences;
    colors = another.colors;
    nowPlaying = another.nowPlaying;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }