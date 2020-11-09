import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/res/strings.dart' as strings;
import 'package:jay_fm_flutter/services/admob_service.dart';
import 'package:jay_fm_flutter/services/database_service.dart';
import 'package:jay_fm_flutter/services/podcasts_service.dart';
import 'package:jay_fm_flutter/services/podcast_stream_controller.dart';
import 'package:jay_fm_flutter/util/stateful_wrapper.dart';
import 'package:just_audio/just_audio.dart';
import 'package:redux/redux.dart';

import 'package:jay_fm_flutter/screens/home/home.dart';
import 'package:jay_fm_flutter/redux/reducers.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/themes.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AudioPlayer audioPlayer = AudioPlayer();

  Admob.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setUpGetIt();

  final _initialState = AppState(
      selectedTheme: prefs.getInt(strings.appTheme) != null
          ? SelectedTheme.values[prefs.getInt(strings.appTheme)]
          : SelectedTheme.DARK,
      audioPlayer: audioPlayer,
      podcastQuality: prefs.getInt(strings.podcastQuality) != null
          ? PodcastQuality.values[prefs.getInt(strings.podcastQuality)]
          : PodcastQuality.MED,
      bannerAd: AdmobBanner(
          adUnitId: AdMobService.getbannerAdUnitId(),
          adSize: AdmobBannerSize.BANNER),
      sharedPreferences: prefs);

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
}

class Root extends StatelessWidget {
  final Store<AppState> store;
  PodcastsService get podcastService => GetIt.instance<PodcastsService>();

  const Root({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: switchCase2(store.state.selectedTheme, {
              SelectedTheme.DARK: darkTheme,
              SelectedTheme.LIGHT: lightTheme
            }),
            home: StatefulWrapper(
              store: store,
              onInit: () {
                podcastService.getAllSavedPodcasts();
              },
              onDispose: () {
                podcastService.dispose();
              },
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) => HomePage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
