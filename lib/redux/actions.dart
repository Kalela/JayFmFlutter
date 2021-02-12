import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/now_playing_state.dart';

class SelectedThemeAction {
  final SelectedTheme payload;

  SelectedThemeAction(this.payload);
}

class PodcastQualityAction {
  final PodcastQuality payload;

  PodcastQualityAction(this.payload);
}

class NowPlayingAction {
  final NowPlaying payload;

  NowPlayingAction(this.payload);
}