import 'package:firstflutterapp/models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper{

  static Future<sql.Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)"
        );
      },
      version: 1,
    );
  }

  static Future<void> insert({String table, Map<String, Object> data}) async {
    final db = await database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData({String table}) async {
    final db = await database();
    return db.query(table, );
  }
}




















