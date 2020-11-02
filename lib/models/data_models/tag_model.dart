import 'package:flutter/cupertino.dart';
import 'package:task_app/services/database/tables/tags_table.dart';

class Tag {
  final title;
  final displayName;
  final meta;
  final description;

  Tag({this.title, this.displayName, this.meta, this.description});

  factory Tag.fromMap(Map tag) {
    String title = tag[TagsTable.titleColumn];
    String displayName = tag[TagsTable.displayNameColumn];
    String meta = tag[TagsTable.metaColumn];
    String description = tag[TagsTable.descriptionColumn];
    Tag tempTag = Tag(
        title: title.toString(),
        displayName: displayName.toString(),
        meta: meta.toString(),
        description: description.toString());
    return tempTag;
  }

  Map toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      TagsTable.titleColumn: title,
      TagsTable.displayNameColumn: displayName,
      TagsTable.metaColumn: meta,
      TagsTable.descriptionColumn: description
    };
    return map;
  }
}
