import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterbook/notes/notes.dart';
import 'package:path_provider/path_provider.dart';
import "utils.dart" as utils;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  print("## main(): FlutterBook Starting");

  startMeUp() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    utils.docsDir = docsDir;
    runApp(FlutterBook());
  }

  startMeUp();
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Book"),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.date_range),
              text: "Appointments",
            ),
            Tab(
              icon: Icon(Icons.contacts),
              text: "Contacts",
            ),
            Tab(
              icon: Icon(Icons.note),
              text: "Notes",
            ),
            Tab(
              icon: Icon(Icons.assignment_turned_in),
              text: "Tasks",
            )
          ]),
        ),
        body: TabBarView(children: [
          Notes(),
          Container(),
          Container(),
          Container(),
        ]),
      ),
    ));
  }
}
