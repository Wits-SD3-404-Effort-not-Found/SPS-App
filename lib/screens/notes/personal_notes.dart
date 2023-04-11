import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/note_item.dart';

class PersonalNotesPage extends StatelessWidget {
  PersonalNotesPage({super.key});
  final List<ListItem> items = [
    NotesItem("Example List Item", "do rotation summary write up"),
    ProtocolItem("Example Protocol", "Run burn wound under cold water"),
    NotesItem("My Notes", "do homework, do that, do this"),
    ProtocolItem("Gun", "call the MF-ing Police"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: items.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListTile(
            title: item.buildItem(context),
          );
        },
      ),
    );
  }
}
