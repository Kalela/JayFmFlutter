import 'package:JayFm/models/now_playing_state.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class JayFmPlayerService {
  AudioPlayer get audioPlayer => GetIt.instance<AudioPlayer>();
  ConcatenatingAudioSource playlist;
  final _nowPlayingStream = BehaviorSubject<NowPlaying>();
  Stream<NowPlaying> get nowPlayingStream => _nowPlayingStream.stream;

  Function(NowPlaying) get changeNowPlaying => _nowPlayingStream.sink.add;

  JayFmPlayerService({this.playlist}) {
    _init(playlist);
  }

  _init(ConcatenatingAudioSource playlist) async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }

  /// Play audio provided by [audioUrl]
  playAudio(BuildContext context, String audioUrl, NowPlaying nowPlaying,
      [ConcatenatingAudioSource playlist]) async {
    var previouslyPlaying = await this.nowPlayingStream.first;
    if (audioPlayer.playing && previouslyPlaying.audioUrl != audioUrl) {
      await audioPlayer.pause();
      nowPlaying = NowPlaying(nowPlaying.imageUrl, nowPlaying.title,
          nowPlaying.presenters, nowPlaying.audioUrl);
      this.changeNowPlaying(nowPlaying);
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
        nowPlaying.presenters, nowPlaying.audioUrl);
    this.changeNowPlaying(nowPlaying);
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

  dispose() {
    _nowPlayingStream.close();
    audioPlayer.dispose();
  }
}
