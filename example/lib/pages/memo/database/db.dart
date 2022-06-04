import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'memo.dart';

final String TableName = 'memos';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if ( _db != null ) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'memos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memos(id TEXT PRIMARY KEY, title TEXT, text TEXT, createTime TEXT, editTime TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertMemo(Memo memo) async {
    final db = await database;

    await db.insert(
      TableName,
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Memo>> findMemo(String id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('memos', where: 'id = ', whereArgs: [id] );

    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        createTime: maps[i]['createTime'],
        editTime: maps[i]['editTime'],
        //image: maps[i]['image'],
      );
    });
  }

  Future<List<Memo>> memos() async {

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('memos');

    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        createTime: maps[i]['createTime'],
        editTime: maps[i]['editTime'],
        //image: maps[i]['image'],
      );
    });
  }

  Future<void> updateMemo(Memo memo) async {
    final db = await database;

    await db.update(
      TableName,
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteMemo(String id) async {
    final db = await database;

    await db.delete(
      TableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}