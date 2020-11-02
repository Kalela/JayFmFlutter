import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/redux/actions.dart';
import 'package:jay_fm_flutter/res/colors.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SelectedThemeAction) {
    newState.selectedTheme = action.payload;
    
    if (action.payload == SelectedTheme.DARK) {
      newState.colors = GlobalAppColors(
          mainBackgroundColor: jayFmFancyBlack,
          mainButtonsColor: Colors.grey,
          mainIconsColor: Colors.blueGrey,
          mainTextColor: Colors.white);
    } else {
      newState.colors = GlobalAppColors(
          mainBackgroundColor: jayFmBlue,
          mainButtonsColor: jayFmFancyBlack,
          mainIconsColor: jayFmOrange,
          mainTextColor: Colors.black);
    }
  } else if (action is PodcastQualityAction) {
    newState.podcastQuality = action.payload;
  } else if (action is PodcastStateAction) {
    newState.playState = action.payload;
  }

  return newState;
}
