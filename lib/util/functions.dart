import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/redux/actions.dart';
import 'package:jay_fm_flutter/res/strings.dart';
import 'package:jay_fm_flutter/screens/home/widgets.dart';
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

/// Play audio provided by [audioUrl]
playAudio(BuildContext context, String audioUrl) async {
  if (_audioPlayer.playing &&
      _audioPlayer.nowPlayingMap['audio_url'] == audioUrl) {
    _audioPlayer.nowPlayingMap['audio_url'] = null;
    await _audioPlayer.pause();
    return;
  }

  if (_audioPlayer.playing) await _audioPlayer.pause();
  _audioPlayer.nowPlayingMap['audio_url'] = audioUrl;
  _audioPlayer.setVolume(1.0);
  try {
    await _audioPlayer.setUrl(audioUrl);
  } catch (e) {
    print(e);
  }
  await _audioPlayer.play();
}

/// Set information of the currently playing podcast/episode
setNowPlayingInfo(
    {String title,
    String presenters = "Jay Fm",
    String imageUrl =
        "https://static.wixstatic.com/media/194ff5_d06f982159334744802a83b7d33a94ec~mv2_d_4489_3019_s_4_2.png/v1/fill/w_250,h_147,al_c,q_95/Finaly-PNG-LOGO.webp"}) {
  audioPlayer.nowPlayingMap['title'] = title;
  audioPlayer.nowPlayingMap['presenters'] = presenters;
  audioPlayer.nowPlayingMap['image_url'] = imageUrl;
}
