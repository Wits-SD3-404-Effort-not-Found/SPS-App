import 'package:flutter/material.dart';
import 'package:sps_app/widgets/primitive/list_item.dart';
import 'package:sps_app/screens/notes/notes.dart';

class PersonalNotesPage extends StatelessWidget {
  PersonalNotesPage({super.key});
  static var myNoteItem = NotesItem("my note title", "my note content");
  static var myNotesItem_2 = NotesItem("my note title 1", "my note content 1");

  final items = [];

  @override
  Widget build(BuildContext context) {
    items.add(myNoteItem);
    items.add(myNotesItem_2);
    return Scaffold(
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: items.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListTile(
            horizontalTitleGap: 0,
            title: item.buildItem(context),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        child: const Text("Go Back"),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NotesPage()))
        },
      ),
    );
  }
}
