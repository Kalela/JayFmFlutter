import 'package:jay_fm_flutter/models/app_state.dart';

class SelectedThemeAction {
  final SelectedTheme payload;

  SelectedThemeAction(this.payload);
}

class PodcastQualityAction {
  final PodcastQuality payload;

  PodcastQualityAction(this.payload);
}

class NowPlayingAction {
  final dynamic payload;

  NowPlayingAction(this.payload);
}