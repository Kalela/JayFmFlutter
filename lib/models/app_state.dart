import 'package:JayFm/models/global_app_colors.dart';
import 'package:JayFm/models/now_playing_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState {
  final PodcastQuality podcastQuality;
  final SharedPreferences sharedPreferences;

  final GlobalAppColors colors;

  AppState(this.colors, this.sharedPreferences, this.podcastQuality);
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }