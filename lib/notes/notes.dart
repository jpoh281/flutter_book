import 'package:flutter/material.dart';
import 'package:flutterbook/notes/notes_db_worker.dart';
import 'package:flutterbook/notes/notes_entry.dart';
import 'package:flutterbook/notes/notes_list.dart';
import 'package:flutterbook/notes/notes_model.dart';
import 'package:scoped_model/scoped_model.dart';

/// 노트 화면
class Notes extends StatelessWidget {
  Notes() {
    print("## Notes.constructor");

    notesModel.loadData("notes", NotesDBWorker.db);
  }
  @override
  Widget build(BuildContext inContext) {
    print("## Notes.build()");
    return ScopedModel<NotesModel>(
      model: notesModel,
      child: ScopedModelDescendant<NotesModel>(
        builder: (BuildContext inContext, Widget inChild, NotesModel inModel) {
          return IndexedStack(
            index: inModel.stackIndex,
            children: <Widget>[
              NotesList(),
              NotesEntry(),
            ],
          );
        },
      ),
    );
  }
}
