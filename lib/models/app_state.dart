

import 'package:just_audio/just_audio.dart';

class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality = PodcastQuality.MED;
  AudioPlayer audioPlayer; // TODO: Use singleton pattern for audio player
  PodcastState playState = PodcastState.STOPPED;

  AppState({this.selectedTheme, this.audioPlayer});

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
    podcastQuality = another.podcastQuality;
    playState = another.playState;
    audioPlayer = another.audioPlayer;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }

//TODO: Document each of these states
enum PodcastState { PLAYING, PAUSED, STOPPED, BUFFERING, LOADING, READY, COMPLETED, ERRORED }