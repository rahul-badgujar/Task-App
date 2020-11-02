import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/ui/screens/home_screen.dart';
import 'package:task_app/utils/constants.dart';

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
