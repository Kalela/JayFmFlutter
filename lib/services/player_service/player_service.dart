import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/now_playing_state.dart';
import 'package:JayFm/redux/actions.dart';
import 'package:JayFm/res/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

class JayFmPlayerService {
  AudioPlayer get audioPlayer => GetIt.instance<AudioPlayer>();

  /// Play audio provided by [audioUrl]
  playAudio(
      BuildContext context, String audioUrl, NowPlaying nowPlaying) async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
      nowPlaying = NowPlaying(nowPlaying.imageUrl, nowPlaying.title,
          nowPlaying.presenters, nowPlaying.audioUrl, true);
      StoreProvider.of<AppState>(context)
          .dispatch(NowPlayingAction(nowPlaying));
      return;
    }

    audioPlayer.setVolume(1.0);
    try {
      await audioPlayer.setUrl(audioUrl);
    } catch (e) {
      print(e);
    }
    await audioPlayer.play();
    nowPlaying = NowPlaying(nowPlaying.imageUrl, nowPlaying.title,
          nowPlaying.presenters, nowPlaying.audioUrl, false);
    StoreProvider.of<AppState>(context).dispatch(NowPlayingAction(nowPlaying));
  }

  // /// Set information of the currently playing podcast/episode
  // setNowPlayingInfo(BuildContext context,
  //     {String title,
  //     String presenters = "Jay Fm",
  //     String imageUrl =
  //         "https://static.wixstatic.com/media/194ff5_d06f982159334744802a83b7d33a94ec~mv2_d_4489_3019_s_4_2.png/v1/fill/w_250,h_147,al_c,q_95/Finaly-PNG-LOGO.webp",
  //     String audioUrl = mainPodcastUrl}) {
  //   StoreProvider.of<AppState>(context).dispatch(
  //       NowPlayingAction(NowPlaying(imageUrl, title, presenters, audioUrl)));
  // }
}
