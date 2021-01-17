import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/screens/now_playing/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NowPlayingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: state.colors.mainBackgroundColor,
            body: Container(
              child: Column(
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/about-you-placeholder.jpg'),
                              fit: BoxFit.fill),
                        ),
                      )),
                  Flexible(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            seeker(state),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            statusRow(state),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: playerRow(state),
                            ),
                            Spacer()
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}