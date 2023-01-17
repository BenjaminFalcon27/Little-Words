import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/word.model.dart';

class DatabaseHelper {
  static const int _version = 3;
  static const String _dbName = "LittleWords.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE LittleWords ('id' INTEGER PRIMARY KEY,'uid' INTEGER, 'author' TEXT NOT NULL, 'content' TEXT NOT NULL, 'longitude' DOUBLE, 'latitude' DOUBLE);");
      await db.execute("CREATE TABLE User ('name' TEXT NOT NULL);");
    }, version: _version);
  }

  //* CREATE WORD
  static Future<int> addWord(Word word) async {
    final db = await _getDB();
    return await db.insert("LittleWords", word.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* READ WORDS
  static Future<List<Word>?> getAllWord() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("LittleWords");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Word.fromJson(maps[index]));
  }

  //$ READ WORDS BY ID
  static Future<Word?> getWordById(int id) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("LittleWords", where: "uid= ?", whereArgs: [id]);

    if (maps.isEmpty) {
      return null;
    }

    return Word.fromJson(maps.first);
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

  //* CREATE USER
  static Future<int> addUser(String name) async {
    final db = await _getDB();
    return await db.insert("User", {"name": name},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* GET USER
  static Future<String?> getUser() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("User");
    if (maps.isEmpty) {
      return null;
    }
    return maps[0]["name"];
  }
}
