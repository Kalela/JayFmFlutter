import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class JayFmPlayerService {
  /// Update the playlist queue
  Future setPlaylist(ConcatenatingAudioSource playlist) async {
    List<MediaItem> queue = [];
    try {
      for (AudioSource episode in playlist.children) {
        print("service data provided is ${episode.sequence[0].tag}");
        MediaItem item = MediaItem(
          id: episode.sequence[0].tag.url,
          album: episode.sequence[0].tag.presenters,
          artUri: Uri.parse(episode.sequence[0].tag.artwork),
          artist: episode.sequence[0].tag.presenters,
          title: episode.sequence[0].tag.title,
        );
        queue.add(item);
      }
      print("updating playlist");
      AudioService.updateQueue(queue);
    } on Exception catch (e) {
      print("An error occured $e");
    }
  }

  /// Pause audio
  Future pauseAudio() async {
    await AudioService.pause();
  }

  /// Play queued audio
  Future playAudio() async {
    await AudioService.play();
  }

  /// Play a single audio source
  Future playItem(AudioSource source) async {
    MediaItem item = MediaItem(
        id: source.sequence[0].tag.title,
        album: source.sequence[0].tag.presenters,
        title: source.sequence[0].tag.title,
        artist: source.sequence[0].tag.presenters);
    AudioService.playMediaItem(item);
    await playAudio();
  }
}
