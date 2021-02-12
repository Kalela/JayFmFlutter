
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class JayFmPlayerService {

  Future setPlaylist(ConcatenatingAudioSource playlist) async {
    List<MediaItem> queue = new List();
    try {
      for (AudioSource episode in playlist.children) {
        MediaItem item = MediaItem(
          id: episode.sequence[0].tag.title,
          album: episode.sequence[0].tag.presenters,
          artUri: episode.sequence[0].tag.artwork,
          artist: episode.sequence[0].tag.presenters,
          title: episode.sequence[0].tag.title,
        );
        queue.add(item);
      }
      AudioService.updateQueue(queue);
    } on Exception catch (e) {
      print("An error occured $e");
    }
  }

  pauseAudio() {
    AudioService.pause();
  }

  playAudio2() {
    AudioService.play();
  }

  playItem(AudioSource source) {
    MediaItem item = MediaItem(
        id: source.sequence[0].tag.title,
        album: source.sequence[0].tag.presenters,
        title: source.sequence[0].tag.title,
        artist: source.sequence[0].tag.presenters);
    AudioService.playMediaItem(item);
    playAudio2();
  }

  playAudio(ConcatenatingAudioSource playlist) async {
    List<MediaItem> queue = new List();

    for (AudioSource episode in playlist.children) {
      MediaItem item = MediaItem(
          id: episode.sequence[0].tag.title,
          album: episode.sequence[0].tag.presenters,
          artist: episode.sequence[0].tag.presenters,
          artUri: episode.sequence[0].tag.artwork,
          title: episode.sequence[0].tag.title);
      queue.add(item);
    }

    await AudioService.updateQueue(queue);
    await AudioService.play();
  }
}


