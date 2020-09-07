import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbook/notes/notes_db_worker.dart';
import 'package:flutterbook/notes/notes_model.dart';
import 'package:scoped_model/scoped_model.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("## NotesList.build()");

    return ScopedModel<NotesModel>(
      model: notesModel,
      child: ScopedModelDescendant<NotesModel>(
        builder: (BuildContext inContext, Widget inChild, NotesModel inModel) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                notesModel.entityBeingEdited = Note();
                notesModel.setColor(null);
                notesModel.setStackIndex(1);
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
            body: ListView.builder(
                itemCount: notesModel.entityList.length,
                itemBuilder: (BuildContext inContext, int inIndex) {
                  Note note = notesModel.entityList[inIndex];
                  Color color = Colors.white;
                  switch (note.color) {
                    case "red":
                      color = Colors.red;
                      break;
                    case "green":
                      color = Colors.green;
                      break;
                    case "blue":
                      color = Colors.blue;
                      break;
                    case "yellow":
                      color = Colors.yellow;
                      break;
                    case "grey":
                      color = Colors.grey;
                      break;
                    case "purple":
                      color = Colors.purple;
                      break;
                  }
                  return Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: .25,
                          secondaryActions: [
                            IconSlideAction(
                                caption: "Delete",
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () => _deleteNote(inContext, note))
                          ],
                          child: Card(
                              elevation: 8,
                              color: color,
                              child: ListTile(
                                  title: Text("${note.title}"),
                                  subtitle: Text("${note.content}"),
                                  // Edit existing note.
                                  onTap: () async {
                                    // Get the data from the database and send to the edit view.
                                    notesModel.entityBeingEdited =
                                        await NotesDBWorker.db.get(note.id);
                                    notesModel.setColor(
                                        notesModel.entityBeingEdited.color);
                                    notesModel.setStackIndex(1);
                                  })) /* End Card. */
                          ));
                }),
          );
        },
      ),
    );
  }

  Future _deleteNote(BuildContext inContext, Note inNote) async {
    print("## NotestList._deleteNote(): inNote = $inNote");
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: Text("Delete Note"),
            content: Text("Are you sure you want to delete ${inNote.title}?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(inAlertContext).pop();
                  },
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () async {
                    await NotesDBWorker.db.delete(inNote.id);
                    Navigator.of(inAlertContext).pop();
                    Scaffold.of(inContext).showSnackBar(
                      SnackBar(
                        content: Text("Note Delete"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    notesModel.loadData("notes", NotesDBWorker.db);
                  },
                  child: Text("Delete"))
            ],
          );
        });
  }
}
