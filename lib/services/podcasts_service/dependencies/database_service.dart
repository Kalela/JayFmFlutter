import 'dart:async';

import 'package:JayFm/models/podcast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseService {

  static Database _database;

  /// Set up the database
  Future<Database> get database async {
    if(_database != null) return _database;

    final Future<Database> db = openDatabase(
      path.join(await getDatabasesPath(), 'jayfm.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Podcast (name TEXT, url TEXT, isCastbox INTEGER, description TEXT);');
      },
    );

    _database = await db;

    return _database;
  }

  /// Insert a new table into the database
  Future insertPodcastToTable(Podcast podcast) async {
    int podcastBoolean =
        podcast.isCastbox ? 1 : 0; // Convert boolean to integer
    Database db = await database;
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Podcast(name, isCastbox, url, description) VALUES("${podcast.name}", "$podcastBoolean", "${podcast.url}", "${podcast.description}")');
    });
  }

  /// Get saved podcasts from the on device database
  Future<List<Map>> getAllSavedPodcasts() async {
    Database db = await database;
    return await db.query('Podcast');
  }

  Future<int> deletePodcast(Podcast podcast) async {
    Database db = await database;
    return db.rawDelete('DELETE FROM Podcast WHERE name = ?', [podcast.name]);
  }
}
