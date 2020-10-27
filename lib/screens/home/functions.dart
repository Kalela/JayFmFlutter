import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/screens/details/details.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:just_audio/just_audio.dart';


openPodcastEpisodes(BuildContext context, String feedUrl) {
  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        title: "Episodes",
                        feedUrl: feedUrl,
                      )));
}

/// Set up state listener for the audio player
setAudioStateListener(AppState state, BuildContext context) {
  state.audioPlayer.playerStateStream.listen((playerState) {
    print("Current player state is ${playerState.processingState}");
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