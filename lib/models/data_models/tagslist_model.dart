import 'package:flutter/cupertino.dart';
import 'package:task_app/models/data_models/tag_model.dart';
import 'package:task_app/services/database/tables/tags_table.dart';

class TagListModel extends ChangeNotifier {
  List<Tag> tagsList;
  List<Tag> permTagsList;
  Future<void> loadTagsList() async {
    await TagsTable().storeApiData();
  }

  Future<void> loadAllTags() async {
    var list = await TagsTable().loadTagsData();
    tagsList = list;
    permTagsList = list;
    print(tagsList);
    notifyListeners();
  }

  void applySearchFilter(String query) {
    List<Tag> tList = List();
    for (Tag tag in permTagsList) {
      if (tag.displayName.toString().contains(query) ||
          tag.description.toString().contains(query)) {
        tList.add(tag);
        print("Adding");
      }
    }
    tagsList = tList;
    notifyListeners();
  }
}
