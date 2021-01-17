import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/util/global_widgets.dart';
import 'package:flutter/material.dart';

Widget playerRow(AppState state) {
  final _iconSize2 = 50.0;
  final _playButtonDiameter = 100.0;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
          flex: 1,
          child: Icon(
            Icons.skip_previous_outlined,
            color: state.colors.mainButtonsColor,
            size: _iconSize2,
          )),
      Flexible(
          flex: 3,
          child: Container(
              height: _playButtonDiameter,
              width: _playButtonDiameter,
              child: RawMaterialButton(
                  onPressed: () {
                    // playAudio(context, mainPodcastUrl);
                    // setNowPlayingInfo(title: "Jay Fm Live");
                  },
                  fillColor: state.colors.mainButtonsColor,
                  shape: CircleBorder(),
                  elevation: 10.0,
                  child: Center(
                      child: PlayerStateIconBuilder(
                          _playButtonDiameter, mainPodcastUrl, state))))),
      Flexible(
          flex: 1,
          child: Icon(
            Icons.skip_next_outlined,
            color: state.colors.mainButtonsColor,
            size: _iconSize2,
          )),
    ],
  );
}

Widget statusRow(AppState state) {
  final _iconSize = 35.0;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
          flex: 1,
          child: Icon(
            Icons.add,
            color: state.colors.mainButtonsColor,
            size: _iconSize,
          )),
      Flexible(
          flex: 3,
          child: Column(children: [
            Text(
              "Youth",
              style: defaultTextStyle(state),
            ),
            Text(
              "Youth",
              style: defaultTextStyle(state),
            )
          ])),
      Flexible(
          flex: 1,
          child: Icon(
            Icons.shuffle,
            color: state.colors.mainButtonsColor,
            size: _iconSize,
          )),
    ],
  );
}

Widget seeker(AppState state) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Divider(
        color: state.colors.mainTextColor,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "2.37",
              style: defaultTextStyle(state),
            ),
            Text(
              "2.37",
              style: defaultTextStyle(state),
            ),
          ],
        ),
      )
    ],
  );
}
