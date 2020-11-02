import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:just_audio/just_audio.dart';

class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality = PodcastQuality.MED;
  AudioPlayer audioPlayer; // TODO: Use singleton pattern for audio player
  PodcastState playState = PodcastState.STOPPED;
  bool showBannerAd = true;
  GlobalAppColors colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white);

  AppState({this.selectedTheme, this.audioPlayer});

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
    podcastQuality = another.podcastQuality;
    playState = another.playState;
    audioPlayer = another.audioPlayer;
    showBannerAd = another.showBannerAd;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }

//TODO: Document each of these states
enum PodcastState { PLAYING, PAUSED, STOPPED, BUFFERING, LOADING, READY, COMPLETED, ERRORED }