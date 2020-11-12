import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:rxdart/rxdart.dart';

class PodcastStreamController {
  var savedPodcasts = BehaviorSubject<List<Podcast>>();

  /// Dispose the stream controller
  void dispose() {
    savedPodcasts.close();
  }

  /// Get podcasts from the database and add them to the saved podcasts stream
  getSavedPodcasts(List<Podcast> podcasts) async {
    this.savedPodcasts.add(podcasts);
  }

  /// Add a new saved podcast to the stream.
  addPodcastToStream(List<Podcast> podcasts) async {
    this.savedPodcasts.add(podcasts);
  }
}
