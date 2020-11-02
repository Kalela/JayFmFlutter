import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Future<Database> databaseSetup() async {
  final Future<Database> database = openDatabase(
    path.join(await getDatabasesPath(), 'jayfm.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Podcast (name TEXT);');
    },
  );

  return database;
}

Future getPodcastsFromTable(AppState state) async {
  List<Map> addresses = await state.database.query('Podcast');

  return addresses;
}

Future insertPodcastToTable() {
  
}