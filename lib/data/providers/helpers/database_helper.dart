import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _instance;
  static Database get instance => _instance;

  static Future<void> createDatabase() async {
    await openDatabase(
      'gameaway.db',
      version: 1,
      onCreate: (db, version) async {
        await db
            .execute(
                'CREATE TABLE giveaway (id INTEGER,title TEXT,worth TEXT,thumbnail TEXT,image TEXT,description TEXT,instructions TEXT,open_giveaway_url TEXT,published_date TEXT,type TEXT,platforms TEXT,end_date TEXT, users INTEGER,status TEXT,gamerpower_url TEXT,open_giveaway TEXT)')
            .catchError((error) {});
        await db
            .execute(
                'CREATE TABLE freetoplay (id INTEGER,title TEXT,thumbnail TEXT,short_description TEXT,game_url TEXT,genre TEXT,platform TEXT,publisher TEXT,developer TEXT,release_date TEXT,freetogame_profile_url TEXT)')
            .catchError((error) {});
      },
      onOpen: (db) => _instance = db,
    );
  }

  static Future<void> insertIntoDatabase(
      {required String tableName, required Map<String, dynamic> data}) async {
    await _instance.insert(tableName, data);
  }

  static Future<List<Map<String, dynamic>>> getDatafromDatabase(
      {required String tableName}) async {
    return await _instance.rawQuery('Select * from $tableName');
  }

  static Future<void> deletefromDatabase(
      {required int id, required String tableName}) async {
    await _instance.delete(
      tableName,
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
