import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/util/ad_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:redux/redux.dart';

import 'package:jay_fm_flutter/screens/home/home.dart';
import 'package:jay_fm_flutter/redux/reducers.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/themes.dart';
import 'package:jay_fm_flutter/util/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AudioPlayer.logEnabled = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  await _initAdMob();

  final _initialState =
      AppState(selectedTheme: SelectedTheme.DARK, audioPlayer: audioPlayer);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(Root(
    store: _store,
  ));
}

Future<void> _initAdMob() {
  return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
}

class Root extends StatelessWidget {
  final Store<AppState> store;

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
            home: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) => HomePage(),
            ),
          );
        },
      ),
    );
  }
}
