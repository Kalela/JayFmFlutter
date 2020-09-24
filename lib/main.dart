import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:jay_fm_flutter/screens/home/home.dart';
import 'models/app_state.dart';


void main() {
  final _initialState = AppState(selectedTheme: SelectedTheme.LIGHT);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

