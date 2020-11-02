import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/models/data_models/tagslist_model.dart';
import 'package:task_app/services/database/tables/tags_table.dart';

class DBHelper {
  static const DB_NAME = "Data.db";
  static const DB_VERSION = 2;

  DBHelper._privateConstructor();
  static final DBHelper _instance = DBHelper._privateConstructor();

  factory DBHelper() {
    return _instance;
  }

  static Database _db;
  Future<Database> get database async {
    if (_db == null) {
      _db = await _initDatabase();
    }
    return _db;
  }

  Future<Database> _initDatabase() async {
    var docPath = await getApplicationDocumentsDirectory();
    String dbPath = join(docPath.path, DB_NAME);
    return openDatabase(dbPath, version: DB_VERSION, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    return await db.execute(TagsTable.createTableSql());
  }
}
