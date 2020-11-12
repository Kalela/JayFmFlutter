import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality = PodcastQuality.MED;
  SharedPreferences sharedPreferences;
  dynamic nowPlaying;

  GlobalAppColors colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white,
          textTheme: darkTextTheme
          );

  AppState({this.selectedTheme, this.sharedPreferences, this.podcastQuality}){
    // Set dark or light theme on app start. Usually gotten from users shared preferences.
    if (selectedTheme == SelectedTheme.DARK) {
      colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white,
          textTheme: darkTextTheme
          );
    } else {
      colors = GlobalAppColors(
          mainBackgroundColor: jayFmBlue,
          mainButtonsColor: jayFmFancyBlack,
          mainIconsColor: jayFmOrange,
          mainTextColor: Colors.black,
          textTheme: lightTextTheme
          );
    }
  }

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
    podcastQuality = another.podcastQuality;
    sharedPreferences = another.sharedPreferences;
    colors = another.colors;
    nowPlaying = another.nowPlaying;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }