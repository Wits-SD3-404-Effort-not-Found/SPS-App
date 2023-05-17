import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/single_note.dart';
import 'package:sps_app/widgets/primitive/list_item.dart';
import '../../http_handler.dart';

class PersonalNotesPage extends StatefulWidget {
  const PersonalNotesPage({super.key});
  @override
  State<PersonalNotesPage> createState() => PersonalNotesPageState();
}

// coverage:ignore-start
class PersonalNotesPageState extends State<PersonalNotesPage> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  var items = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getNotes(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ));
          } else {
            items.clear();
            for (var note in snapshot.data) {
              if (note["noteID"] != null &&
                  note["noteTitle"] != null &&
                  note["noteContent"] != null) {
                items.add(NotesItem(
                    note["noteTitle"], note["noteContent"], note["noteID"]));
              }
            }
            return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Column(children: [
                  Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2))),
                      child: Row(children: [
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )))),
                        Container(
                            height: 50,
                            width: 250,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Personal Notes",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              textAlign: TextAlign.left,
                            )),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: GestureDetector(
                                    onTap: () {
                                      var newNote = NotesItem("Note Title", "");
                                      newNote
                                          .getNoteContent()
                                          .setIsNewNote(true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleNotePage(
                                                    noteContent: newNote
                                                        .getNoteContent()),
                                          ));
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )))),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        build(context);
                                      });
                                    },
                                    child: Icon(
                                      Icons.refresh,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )))),
                      ])),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      // Let the ListView know how many items it needs to build.
                      itemCount: items.length,
                      // Provide a builder function.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];
                        return ListTile(
                          horizontalTitleGap: 0,
                          minVerticalPadding: 5,
                          title: item.buildItem(context),
                        );
                      },
                    ),
                  )
                ]));
          }
        });
  }
}// coverage:ignore-end
