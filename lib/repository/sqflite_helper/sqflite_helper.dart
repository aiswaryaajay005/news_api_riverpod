import 'package:news_api_riverpod/repository/app_config/app_config.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static late Database database;

  static Future initDb() async {
    database = await openDatabase(
      "save.db",
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE ${AppConfig.tableName} (${AppConfig.primaryKey} INTEGER PRIMARY KEY, ${AppConfig.newsTitle} TEXT, ${AppConfig.newsSource} TEXT, ${AppConfig.imageUrl} TEXT, ${AppConfig.isSaved} INT)',
        );
      },
    );
  }

  static Future<List<Map>> getAllData() async {
    // Get the records
    List<Map> items = await database.rawQuery(
      'SELECT * FROM ${AppConfig.tableName}',
    );
    return items;
  }

  static Future<void> addNewData({
    required String? title,
    required String? source,
    required String? imageUrl,
    int isSaved = 1,
  }) async {
    await database.rawInsert(
      'INSERT INTO ${AppConfig.tableName}(${AppConfig.newsTitle}, ${AppConfig.newsSource}, ${AppConfig.imageUrl}, ${AppConfig.isSaved}) VALUES(?, ?, ?, ?)',
      [title ?? 'Untitled', source ?? 'Unknown', imageUrl ?? '', isSaved],
    );
  }

  static Future<void> deleteNews(int id) async {
    await database.rawDelete(
      'DELETE FROM ${AppConfig.tableName} WHERE ${AppConfig.primaryKey} = ?',
      [id],
    );
  }

  static Future<bool> isNewsSaved(String title) async {
    final result = await database.query(
      AppConfig.tableName,
      where: '${AppConfig.newsTitle} = ?',
      whereArgs: [title],
    );
    return result.isNotEmpty;
  }
}
