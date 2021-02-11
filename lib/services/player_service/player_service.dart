import 'package:JayFm/models/now_playing_state.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class JayFmPlayerService {
  AudioPlayer get audioPlayer => GetIt.instance<AudioPlayer>();
  ConcatenatingAudioSource playlist;
  final _nowPlayingStream = ReplaySubject<NowPlaying>();

  /// Currently playing
  Stream<NowPlaying> get nowPlayingStream => _nowPlayingStream.stream;

  Function(NowPlaying) get changeNowPlaying => _nowPlayingStream.sink.add;

  JayFmPlayerService() {
    _init();
  }

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }

  Future setPlaylist(ConcatenatingAudioSource playlist) async {
    try {
      await audioPlayer.setAudioSource(playlist);
    } on Exception catch (e) {
      print("An error occured $e");
    }
  }

  dispose() {
    _nowPlayingStream.close();
    audioPlayer.dispose();
  }
}
