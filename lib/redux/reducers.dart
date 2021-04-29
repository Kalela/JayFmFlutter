import 'package:JayFm/models/global_app_colors.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/colors.dart';

AppState reducer(AppState state, dynamic action) => new AppState(
      themeReducer(state.colors, action),
      state.sharedPreferences,
      podcastQualityReducer(state.podcastQuality, action),
    );

GlobalAppColors themeReducer(GlobalAppColors colors, dynamic action) {
  if (!(action is SelectedThemeAction)) {
    return colors;
  }

  if (action.payload == SelectedTheme.LIGHT) {
    colors = lightColors;
  } else if (action.payload == SelectedTheme.DARK) {
    colors = darkColors;
  }

  return colors;
}

PodcastQuality? podcastQualityReducer(PodcastQuality? quality, dynamic action) {
  return action is PodcastQualityAction ? action.payload : quality;
}
