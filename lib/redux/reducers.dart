import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SelectedThemeAction) {
    newState.selectedTheme = action.payload;
  } else if (action is PodcastQualityAction) {
    newState.podcastQuality = action.payload;
  }

  return newState;
}