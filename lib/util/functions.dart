import 'package:JayFm/util/audio_player_task.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/strings.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

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

launchApp(url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      universalLinksOnly: true,
    );
  } else {
    throw 'There was a problem to open the url: $url';
  }
}

/// A stream reporting the combined state of the current queue and the current
/// media item within that queue.
Stream<QueueState> get queueStateStream =>
    Rx.combineLatest2<List<MediaItem>, MediaItem, QueueState>(
        AudioService.queueStream,
        AudioService.currentMediaItemStream,
        (queue, mediaItem) => QueueState(queue, mediaItem));
