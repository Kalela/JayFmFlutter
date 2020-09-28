import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:jay_fm_flutter/screens/home/home.dart';
import 'package:jay_fm_flutter/redux/reducers.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/themes.dart';
import 'package:jay_fm_flutter/util/functions.dart';

void main() {
  final _initialState = AppState(selectedTheme: SelectedTheme.LIGHT);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(Root(
    store: _store,
  ));
}

class Root extends StatelessWidget {
  final Store<AppState> store;

  const Root({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: switchCase2(store.state.selectedTheme,
            {SelectedTheme.DARK: darkTheme, SelectedTheme.LIGHT: lightTheme}),
        home: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => HomePage(),
        ),
      ),
    );
  }
}
