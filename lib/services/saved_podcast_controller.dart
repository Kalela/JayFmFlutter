import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/services/database_service.dart';

class SavedPodcastController {
  DatabaseService get _databaseService => GetIt.instance<DatabaseService>();

  final StreamController<List<Podcast>> _savedPodcastStreamController =
      StreamController<List<Podcast>>.broadcast();

  Stream<List<Podcast>> get savedPodcasts =>
      _savedPodcastStreamController.stream;

  Sink<List<Podcast>> get newSavedPodcasts =>
      _savedPodcastStreamController.sink;

  /// Dispose the stream controller
  void dispose() {
    _savedPodcastStreamController.close();
  }

  /// Get podcasts from the database and add them to the saved podcasts stream
  getSavedPodcasts() async {
    List<Map> results = await _databaseService.getAllSavedPodcasts();
    List<Podcast> podcasts = List();

    for (var podcast in results) {
      Podcast newPodcast = Podcast();
      newPodcast.name = podcast['name'];
      newPodcast.url = podcast['url'];
      newPodcast.isCastbox = false; // TODO: Find better way of doing this check
      if (podcast['isCastbox'] == 1) newPodcast.isCastbox = true;

      podcasts.add(newPodcast);
    }

    print("Podcasts found are ${podcasts}");
    print("Snapshot controller self ${this.hashCode}");

    newSavedPodcasts.add(podcasts);
  }

  /// Add a new saved podcast to the stream.
  addPodcastToStream(Podcast podcast) {
    savedPodcasts.last.then((value) {
      value.add(podcast);
      newSavedPodcasts.add(value);
    });
  }
}
