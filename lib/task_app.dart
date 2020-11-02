import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/data_models/tagslist_model.dart';
import 'package:task_app/ui/screens/home_screen.dart';
import 'package:task_app/utils/constants.dart';

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChangeNotifierProvider<TagListModel>.value(
        value: TagListModel(),
        child: HomeScreen(),
      ),
    );
  }
}
