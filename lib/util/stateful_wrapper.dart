import 'package:JayFm/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/res/strings.dart';
import 'package:redux/redux.dart';

///Enable use of stateful widget functionality in stateless widgets
///
///
///
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Function onDispose;
  final Widget child;
  final Store<AppState>? store;

  const StatefulWrapper(
      {required this.onInit, required this.onDispose, required this.child, required this.store});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if (widget.onInit != null) {
      widget.onInit();
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose(this);
    }
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.store!.state.sharedPreferences.setInt(appTheme, widget.store!.state.colors.mainBackgroundColor == jayFmFancyBlack ? 0 : 1);
      widget.store!.state.sharedPreferences.setInt(podcastQuality, widget.store!.state.podcastQuality!.index);
    }
  }
}
