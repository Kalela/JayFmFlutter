import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/redux/actions.dart';
import 'package:jay_fm_flutter/res/strings.dart';
import 'package:just_audio/just_audio.dart';

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

/// Set podcast quality
setPodcastQuality(BuildContext context, PodcastQuality value) {
  StoreProvider.of<AppState>(context).dispatch(PodcastQualityAction(value));
}

/// Set podcast players current state
setPodcastIsPlayingState(BuildContext context, PodcastState state) {
  StoreProvider.of<AppState>(context).dispatch(PodcastStateAction(state));
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

playPodcast(AppState state, BuildContext context, String podCastUrl) async {
  setAudioStateListener(state, context);

  if (state.playState == PodcastState.PLAYING) {
    setPodcastIsPlayingState(context, PodcastState.PAUSED);
    await state.audioPlayer.stop();
  } else {
    try {
      await state.audioPlayer.setUrl(podCastUrl);
    } catch (e) {
      print(e);
      setPodcastIsPlayingState(context, PodcastState.ERRORED);
    }
    await state.audioPlayer.play();
  }
}

/// Set up state listener for the audio player
setAudioStateListener(AppState state, BuildContext context) {
  state.audioPlayer.playerStateStream.listen((playerState) {
    if (playerState.playing) {
      setPodcastIsPlayingState(context, PodcastState.PLAYING);
    } else {
      switch (playerState.processingState) {
        case ProcessingState.none:
          setPodcastIsPlayingState(context, PodcastState.STOPPED);
          break;
        case ProcessingState.loading:
          setPodcastIsPlayingState(context, PodcastState.LOADING);
          break;
        case ProcessingState.buffering:
          setPodcastIsPlayingState(context, PodcastState.BUFFERING);
          break;
        case ProcessingState.ready:
          setPodcastIsPlayingState(context, PodcastState.READY);
          break;
        case ProcessingState.completed:
          setPodcastIsPlayingState(context, PodcastState.COMPLETED);
          break;
      }
    }
  });
}
