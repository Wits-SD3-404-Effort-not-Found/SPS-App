import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/single_note.dart';
import 'package:sps_app/screens/notes/single_protocol.dart';
import 'package:sps_app/screens/notes/note_content.dart';

// coverage:ignore-start
abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildItem(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: () {}, child: buildTitle(context)),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 3.0))),
        ),
      ],
    );
  }
}

class ProtocolItem implements ListItem {
  final String protocolTitle;
  final String body;

  ProtocolItem(this.protocolTitle, this.body);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(protocolTitle,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 18));
  }

  @override
  Widget buildItem(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 30,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleProtocolPage(
                        protocolHeading: protocolTitle, protocolContent: body)),
              );
            },
            child: Stack(children: [
              buildTitle(context),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2))),
              ),
            ])));
  }
}

class NotesItem implements ListItem {
  var noteContent = NoteContent();

  NotesItem(String title, String body, bool publicNote, [int? noteID]) {
    noteContent.setTitle(title);
    noteContent.setBody(body);
    noteContent.setIsPublicNote(publicNote);
    if (noteID != null) {
      noteContent.setNoteID(noteID);
    }
  }
  String getItemTitle() {
    return noteContent.getTitle();
  }

  String getItemBody() {
    return noteContent.getBody();
  }

  NoteContent getNoteContent() {
    return noteContent;
  }

  @override
  Widget buildTitle(BuildContext context) => Text(noteContent.getTitle(),
      style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground, fontSize: 18));

  @override
  Widget buildItem(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 30,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SingleNotePage(noteContent: noteContent),
                ),
              );
            },
            child: Stack(children: [
              buildTitle(context),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2))),
              ),
            ])));
  }
} // coverage:ignore-end
