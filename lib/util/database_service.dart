import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Future<Database> databaseSetup() async {
  final Future<Database> database = openDatabase(
    path.join(await getDatabasesPath(), 'jayfm.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Podcast (name TEXT, url TEXT, isCastbox INTEGER);');
    },
  );

  return database;
}

Future<List<Podcast>> getSavedPodcastsFromTable(AppState state) async {
  List<Map> results = await state.database.query('Podcast');
  List<Podcast> podcasts = List();

  for (var podcast in results) {
    Podcast newPodcast = Podcast();
    newPodcast.name = podcast['name'];
    newPodcast.url = podcast['url'];
    newPodcast.isCastbox = false; // TODO: Find better way of doing this check
    if (podcast['isCastbox'] == 1) newPodcast.isCastbox = true;

    podcasts.add(newPodcast);
  }

  return podcasts;
}

Future insertPodcastToTable(AppState state, Podcast podcast) async {
  int podcastBoolean = podcast.isCastbox ? 1 : 0; // Convert boolean to integer
  await state.database.transaction((txn) async {
    print("saving podcast ${podcast.name}");
    print("url ${podcast.url}");
    print("boolean $podcastBoolean");
    await txn.rawInsert(
        'INSERT INTO Podcast(name, isCastbox, url) VALUES("${podcast.name}", "$podcastBoolean", "${podcast.url}")');
  });
}