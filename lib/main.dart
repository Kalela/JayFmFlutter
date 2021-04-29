import 'package:JayFm/models/global_app_colors.dart';
import 'package:JayFm/res/colors.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/res/strings.dart' as strings;
import 'package:JayFm/services/admob_service.dart';
import 'package:JayFm/services/podcasts_service/dependencies/database_service.dart';
import 'package:JayFm/services/podcasts_service/podcasts_service.dart';
import 'package:JayFm/services/player_service/player_service.dart';
import 'package:JayFm/services/podcasts_service/dependencies/podcast_stream_controller.dart';
import 'package:JayFm/util/stateful_wrapper.dart';
import 'package:just_audio/just_audio.dart';
import 'package:redux/redux.dart';

import 'package:JayFm/screens/home/home.dart';
import 'package:JayFm/redux/reducers.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Admob.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setUpGetIt();

  GlobalAppColors colors = darkColors;
  PodcastQuality quality = PodcastQuality.MED;

  if (prefs.getInt(strings.appTheme) != null) {
    if (prefs.getInt(strings.appTheme) == 1) {
      colors = lightColors;
    }
  }

  if (prefs.getInt(strings.podcastQuality) != null) {
    quality = PodcastQuality.values[prefs.getInt(strings.podcastQuality)!];
  }

  final _initialState = AppState(colors, prefs, quality);

  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(Root(
    store: _store,
  ));
}

/// Set up get it DI and service locator
void setUpGetIt() {
  GetIt.instance.registerLazySingleton(() => PodcastStreamController());
  GetIt.instance.registerLazySingleton(() => DatabaseService());
  GetIt.instance.registerLazySingleton(() => PodcastsService());
  GetIt.instance.registerLazySingleton(() => AudioPlayer());
  GetIt.instance.registerLazySingleton(() => AdMobService());
  GetIt.instance.registerLazySingleton(() => JayFmPlayerService());
}

class Root extends StatelessWidget {
  final Store<AppState>? store;
  PodcastsService? get podcastService => GetIt.instance<PodcastsService>();

  const Root({Key? key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store!,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: state.colors.mainBackgroundColor == jayFmFancyBlack
                  ? Colors.blueGrey
                  : Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: StatefulWrapper(
              store: store,
              onInit: () {
                podcastService!.getAllSavedPodcasts();
              },
              onDispose: () {
                podcastService!.dispose();
              },
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) =>
                    AudioServiceWidget(child: HomePage()),
              ),
            ),
          );
        },
      ),
    );
  }
}
