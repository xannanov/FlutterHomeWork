import 'dart:async';
import 'dart:io';

import 'package:namer_app/data/local/model/Favorite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
      return _database!;
    }
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MyDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Favorite("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "word TEXT"
          ")");
    });
  }

  newFavorite(Favorite newFavorite) async {
    final db = await database;

    var raw = await db.rawInsert(
      "INSERT Into Favorite (word)"
      " VALUES (?)",
      [newFavorite.word]
    );

    return raw;
  }

  Future<List<Favorite>> getAllFavorites() async {
    final db = await database;
    var res = await db.query("Favorite");
    List<Favorite> favorites = res.isNotEmpty ? res.map((c) => Favorite.fromMap(c)).toList() : [];

    return favorites;
  }

  deleteFavoriteByWord(String word) async {
    final db = await database;
    return db.delete("Favorite", where: "word = ?", whereArgs: [word]);
  }

  deleteAll() async {
    final db = await database;

    db.rawDelete("Delete * from Favorite");
  }
}
