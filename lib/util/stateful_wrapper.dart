import 'package:flutter/material.dart';

///Enable use of stateful widget functionality in stateless widgets
///
///
///
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Function onDispose;
  final Widget child;

  const StatefulWrapper(
      {@required this.onInit, @required this.onDispose, @required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit();
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
