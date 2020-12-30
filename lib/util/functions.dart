import 'package:JayFm/models/now_playing_state.dart';
import 'package:JayFm/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/strings.dart';
import 'package:JayFm/screens/home/widgets.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer get _audioPlayer => GetIt.instance<AudioPlayer>();

/// set the theme in application state
void setThemeState(BuildContext context, String choice) {
  switch (choice) {
    case darkTheme:
      StoreProvider.of<AppState>(context)
          .dispatch(SelectedThemeAction(SelectedTheme.DARK));
      break;
    case lightTheme:
      StoreProvider.of<AppState>(context)
          .dispatch(SelectedThemeAction(SelectedTheme.LIGHT));
      break;
  }
}

/// Save the podcast quality in app state
setPodcastQuality(BuildContext context, PodcastQuality value) {
  StoreProvider.of<AppState>(context).dispatch(PodcastQualityAction(value));
}

/// Handle selection of an Action from tab bar pop up menu
void tabBarPopUpChoiceAction(String choice, BuildContext context) {
  setThemeState(context, choice);
}

///Helper function for a dynamic switch case with dynamic types
TValue switchCase2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue defaultValue,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}


