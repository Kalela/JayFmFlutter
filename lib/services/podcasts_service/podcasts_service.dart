import 'package:get_it/get_it.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/services/podcasts_service/dependencies/database_service.dart';
import 'package:JayFm/services/podcasts_service/dependencies/podcast_stream_controller.dart';

class PodcastsService {
  PodcastStreamController? get streamController =>
      GetIt.instance<PodcastStreamController>();
  DatabaseService? get _databaseService => GetIt.instance<DatabaseService>();

  /// Perform instructions to save a podcast
  savePodcast(Podcast podcast) async {
    List<Podcast> podcasts = [];
    _databaseService!.insertPodcastToTable(podcast).then((value1) => {
          _databaseService!.getAllSavedPodcasts().then((value2) {
            podcasts = value2
                .map((entry) => Podcast(
                    name: entry['name'],
                    url: entry['url'],
                    isIFrame: entry['isCastbox'] == 1 ? true : false))
                .toList();
            streamController!.addPodcastToStream(podcasts);
          })
        });

    // showToastMessage("Podcast saved");
  }

  /// Get all saved podcasts.
  /// Gets saved podcasts from sqflite database and updates the saved podcasts stream.
  /// Returns the list of added podcasts.
  Future<List<Podcast>> getAllSavedPodcasts() async {
    List<Map> results = await _databaseService!.getAllSavedPodcasts();
    List<Podcast> podcasts = [];

    podcasts = results
        .map((entry) => Podcast(
            name: entry['name'],
            url: entry['url'],
            isIFrame: entry['isCastbox'] == 1 ? true : false))
        .toList();

    streamController!.getSavedPodcasts(podcasts);

    return podcasts;
  }

  deletePodcast(Podcast podcast) async {
    int result;
    result = await _databaseService!.deletePodcast(podcast);

    if (result > 0) {
      getAllSavedPodcasts(); // Update saved tab stream
    }
  }

  /// Dispose resources
  dispose() {
    // showToastMessage("Removed from saved");
    streamController!.dispose();
  }
}
