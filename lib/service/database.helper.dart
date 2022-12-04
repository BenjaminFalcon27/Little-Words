import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/word.model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "LittleWords.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE LittleWords (`uid` INTEGER PRIMARY KEY AUTOINCREMENT, `author` TEXT NOT NULL, `content` TEXT NOT NULL, `longitude` TEXT NOT NULL, `latitude` TEXT NOT NULL);"),
        version: _version);
  }

  //* CREATE
  static Future<int> addWord(Word word) async {
    final db = await _getDB();
    return await db.insert("LittleWords", word.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* READ
  static Future<List<Word>?> getAllWord() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("LittleWords");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Word.fromJson(maps[index]));
  }

  //* UPDATE
  static Future<int> updateDeco(Word word) async {
    final db = await _getDB();
    return await db.update("LittleWords", word.toJson(),
        where: "uid= ?",
        whereArgs: [word.uid],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* DELETE
  static Future<int> deleteDeco(Word word) async {
    final db = await _getDB();
    return await db.delete(
      "LittleWords",
      where: "uid= ?",
      whereArgs: [word.uid],
    );
  }
}
