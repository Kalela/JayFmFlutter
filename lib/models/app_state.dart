import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality = PodcastQuality.MED;
  AudioPlayer audioPlayer;
  PodcastState playState = PodcastState.STOPPED;
  Widget bannerAd;
  SharedPreferences sharedPreferences;

  GlobalAppColors colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white);

  AppState({this.selectedTheme, this.audioPlayer, this.bannerAd, this.sharedPreferences, this.podcastQuality}){
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
    playState = another.playState;
    audioPlayer = another.audioPlayer;
    bannerAd = another.bannerAd;
    sharedPreferences = another.sharedPreferences;
    colors = another.colors;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }

//TODO: Document each of these states
enum PodcastState { PLAYING, PAUSED, STOPPED, BUFFERING, LOADING, READY, COMPLETED, ERRORED }