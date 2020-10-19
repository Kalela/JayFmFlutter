import 'package:jay_fm_flutter/models/app_state.dart';

class SelectedThemeAction {
  final SelectedTheme payload;

  SelectedThemeAction(this.payload);
}

class PodcastQualityAction {
  final PodcastQuality payload;

  PodcastQualityAction(this.payload);
}

class PodcastStateAction {
  final PodcastState payload;

  PodcastStateAction(this.payload);
}