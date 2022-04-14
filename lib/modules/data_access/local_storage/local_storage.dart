import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../home/data/models/local_media_model.dart';
import 'i_local_storage.dart';

class LocalStorage implements ILocalStorage {
  late Database database;

  LocalStorage() {
    intitDb();
  }

  intitDb() async {
    // print('Delete database');
    // var databasesPath = await getDatabasesPath();
    // String path = join(databasesPath, 'nasa_database.db');
    // await deleteDatabase(path);

    database = await openDatabase(
      join(await getDatabasesPath(), 'nasa_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE medias(id INTEGER PRIMARY KEY, copyright TEXT, date TEXT, explanation TEXT, hdurl TEXT, media_type TEXT, service_version TEXT, title TEXT, url TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> insertMedia(LocalMediaModel media) async {
    final db = database;

    await db.insert(
      'medias',
      media.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<LocalMediaModel>> getMediaList() async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('medias');

    return List.generate(maps.length, (i) {
      return LocalMediaModel(
          id: int.parse(maps[i]['date'].replaceAll('-', '')),
          copyright: maps[i]['copyright'],
          date: maps[i]['date'],
          explanation: maps[i]['explanation'],
          hdurl: maps[i]['hdurl'],
          mediaType: maps[i]['media_type'],
          serviceVersion: maps[i]['service_version'],
          title: maps[i]['title'],
          url: maps[i]['url']);
    });
  }
}
