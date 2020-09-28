import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/redux/actions.dart';
import 'package:jay_fm_flutter/res/strings.dart';

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

/// Handle selection of an Action from tab bar pop up menu
void tabBarPopUpChoiceAction(String choice, BuildContext context) {
  setThemeState(context, choice);
}

setPodcastQuality(BuildContext context, PodcastQuality value) {
  StoreProvider.of<AppState>(context)
                          .dispatch(PodcastQualityAction(value));
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
