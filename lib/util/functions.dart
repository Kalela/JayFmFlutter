import 'package:JayFm/services/player_service/player_service.dart';
import 'package:JayFm/util/audio_player_task.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, QueueState>(
        AudioService.queueStream,
        AudioService.currentMediaItemStream,
        AudioService.playbackStateStream,
        (queue, mediaItem, playbackState) =>
            QueueState(queue, mediaItem, playbackState)).asBroadcastStream();

JayFmPlayerService get audioPlayerService =>
    GetIt.instance<JayFmPlayerService>();

checkAudioPlayProcess(QueueState queueStateSnapshot,
    ConcatenatingAudioSource playlist, int i) async {
  if (queueStateSnapshot != null) {
    print("queue state functions ${queueStateSnapshot.queue}");
    if (queueStateSnapshot.queue.isEmpty) {
      // Check if the playlist is an empty list
      await audioPlayerService.setPlaylist(playlist);
      if (i != 0) {
        audioPlayerService.playAudio();
      } else {
        await audioPlayerService.playItem(playlist.children[i]);
      }
      return;
    }

    if (queueStateSnapshot.queue[0].title !=
        playlist.children[0].sequence[0].tag.title) {
      // Check if the playing playlist and the new playlist are not the same
      await audioPlayerService.setPlaylist(playlist);
    }

    if (queueStateSnapshot.mediaItem.title ==
            playlist.children[i].sequence[0].tag.title &&
        queueStateSnapshot.playbackState.playing) {
      // Check if the playing playlist and the new playlist are the same
      await audioPlayerService.pauseAudio();
    } else {
      await audioPlayerService.playItem(playlist.children[0]);
    }
  } else {
    print("I am here");
    await audioPlayerService.setPlaylist(playlist);
    await audioPlayerService.playItem(playlist.children[0]);
  }
}
