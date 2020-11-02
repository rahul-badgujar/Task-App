import 'dart:convert';

import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/models/data_models/tag_model.dart';
import 'package:task_app/services/api/network/http_client.dart';
import 'package:task_app/services/database/dbhelper.dart';

class TagsTable {
  static const String tableName = "Tag";
  static const String idColumn = "id";
  static const String spaceListColumn = "spaceList";
  static const String titleColumn = "title";
  static const String displayNameColumn = "displayName";
  static const String metaColumn = "meta";
  static const String descriptionColumn = "description";

  TagsTable._privateConstructor();
  static final TagsTable _instance = TagsTable._privateConstructor();
  factory TagsTable() {
    return _instance;
  }

  static String createTableSql() {
    String sql = '''
    create table $tableName (
      $idColumn integer primary key autoincrement,
      $titleColumn text not null,
      $displayNameColumn text not null,
      $metaColumn text not null,
      $descriptionColumn text not null
    )
    ''';
    return sql;
  }

  Future<void> storeApiData() async {
    Response response = await HttpRequester().fetchData();
    var jsonData = json.decode(response.body);
    var tagsList = jsonData["tags"];
    List<Tag> tags = List();
    for (var tag in tagsList) {
      tags.add(Tag.fromMap(tag));
    }
    print(tags);
    Database db = await DBHelper().database;
    Batch batch = db.batch();
    for (Tag tag in tags) {
      if (await queryTag(tag) == null) {
        await batch.insert(tableName, tag.toMap());
      }
    }
    await batch.commit();
    print(db.query(tableName));
  }

  Future<List<Tag>> loadTagsData() async {
    await storeApiData();
    Database db = await DBHelper().database;
    List<Map> result = await db.query(tableName) ?? <Map>[];
    if (result.length > 0) {
      List<Tag> tagsList =
          result?.map((e) => e == null ? null : Tag.fromMap(e))?.toList();
      return tagsList;
    }
    return null;
  }

  Future<Tag> queryTag(Tag tag) async {
    Database db = await DBHelper().database;
    List<Map> found = await db.query(
      tableName,
      columns: [titleColumn, displayNameColumn, metaColumn, descriptionColumn],
      where:
          "$titleColumn=? AND $displayNameColumn=? AND $metaColumn=? AND $descriptionColumn=?",
      whereArgs: [tag.title, tag.displayName, tag.meta, tag.description],
    );
    if (found.length > 0) {
      return Tag.fromMap(found.first);
    }

    return null;
  }
}
