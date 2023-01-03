import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/word.model.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "LittleWords.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE LittleWords ('id' INTEGER PRIMARY KEY, 'uid' INTEGER, 'author' TEXT NOT NULL, 'content' TEXT NOT NULL, 'longitude' TEXT NOT NULL, 'latitude' TEXT NOT NULL);"),
        version: _version);
  }

  //* CREATE WORD
  static Future<int> addWord(Word word) async {
    final db = await _getDB();
    return await db.insert("LittleWords", word.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* READ WORD
  static Future<List<Word>?> getAllWord() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("LittleWords");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Word.fromJson(maps[index]));
  }

  //* UPDATE WORD
  static Future<int> updateWord(Word word) async {
    final db = await _getDB();
    return await db.update("LittleWords", word.toJson(),
        where: "id= ?",
        whereArgs: [word.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* DELETE WORD
  static Future<int> deleteWord(Word word) async {
    final db = await _getDB();
    return await db.delete(
      "LittleWords",
      where: "id= ?",
      whereArgs: [word.id],
    );
  }
}
