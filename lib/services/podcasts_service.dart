import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/services/database_service.dart';
import 'package:jay_fm_flutter/services/podcast_stream_controller.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

class PodcastsService {
  PodcastStreamController get streamController =>
      GetIt.instance<PodcastStreamController>();
  DatabaseService get databaseService => GetIt.instance<DatabaseService>();

  /// Perform instructions to save a podcast
  savePodcast(Podcast podcast) async {
    List<Podcast> podcasts = List();
    // TODO: Find an efficient way of using streams to perform this get
    databaseService.insertPodcastToTable(podcast).then((value1) => {
          databaseService.getAllSavedPodcasts().then((value2) {
            podcasts = value2
                .map((entry) => Podcast(
                    name: entry['name'],
                    url: entry['url'],
                    isCastbox: entry['isCastbox'] == 1 ? true : false))
                .toList();
            streamController.addPodcastToStream(podcasts);
          })
        });

    showToastMessage("Podcast saved");
  }

  /// Get all saved podcasts
  getAllSavedPodcasts() async {
    List<Map> results = await databaseService.getAllSavedPodcasts();
    List<Podcast> podcasts = List();

    podcasts = results
        .map((entry) => Podcast(
            name: entry['name'],
            url: entry['url'],
            isCastbox: entry['isCastbox'] == 1 ? true : false))
        .toList();

    streamController.getSavedPodcasts(podcasts);
  }

  /// Dispose resources
  dispose() {
    streamController.dispose();
  }
}
