import 'package:JayFm/models/global_app_colors.dart';
import 'package:JayFm/models/now_playing_state.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/colors.dart';

AppState reducer(AppState state, dynamic action) => new AppState(
    themeReducer(state.colors, action),
    state.sharedPreferences,
    podcastQualityReducer(state.podcastQuality, action),
    nowPlayingReducer(state.nowPlaying, action));

GlobalAppColors themeReducer(GlobalAppColors colors, dynamic action) {
  if (!(action is SelectedThemeAction)) {
    return colors;
  }
  print("I am here selected is ${action.payload}");

  if (action.payload == SelectedTheme.LIGHT) {
    print("returned light");
    colors = lightColors;
  } else if (action.payload == SelectedTheme.DARK) {
    print("returned dark");
    colors = darkColors;
  }

  return colors;
}

PodcastQuality podcastQualityReducer(PodcastQuality quality, dynamic action) {
  print("podcast quality is ${action.payload}");
  return action is PodcastQualityAction ? action.payload : quality;
}

NowPlaying nowPlayingReducer(NowPlaying state, dynamic action) {
  if (action is NowPlayingAction) {
    state = action.payload;
  }

  return state;
}
