import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/data_models/tagslist_model.dart';
import 'package:task_app/services/api/network/http_client.dart';
import 'package:task_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MediaQueryData mediaQueryData;

  @override
  void initState() {
    final tagListModelProvider =
        Provider.of<TagListModel>(context, listen: false);
    tagListModelProvider.loadAllTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.homeScreenTitle),
      ),
      body: Column(
        children: [Expanded(child: _buildDataCardsList())],
      ),
    );
  }

  Widget _buildDataCardsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<TagListModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.tagsList == null ? 0 : model.tagsList.length,
            itemBuilder: (context, index) {
              return _buildDetailsCard(
                  model.tagsList[index].displayName,
                  model.tagsList[index].meta,
                  model.tagsList[index].description);
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailsCard(
      String displayName, String meta, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                child: Text(
                  displayName.toUpperCase(),
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(meta == "null" ? "" : meta,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(description, style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Spaces",
                  style: TextStyle(
                      fontSize: 12, color: Theme.of(context).primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}
