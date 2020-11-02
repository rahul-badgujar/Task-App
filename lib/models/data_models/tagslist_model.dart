import 'package:flutter/cupertino.dart';
import 'package:task_app/models/data_models/tag_model.dart';
import 'package:task_app/services/database/tables/tags_table.dart';

class TagListModel extends ChangeNotifier {
  List<Tag> tagsList;

  Future<void> loadTagsList() async {
    await TagsTable().storeApiData();
  }

  Future<void> loadAllTags() async {
    var list = await TagsTable().loadTagsData();
    tagsList = list;
    print(tagsList);
    notifyListeners();
  }
}
