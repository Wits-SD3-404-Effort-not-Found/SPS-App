import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/single_note.dart';
import 'package:sps_app/screens/notes/single_protocol.dart';
import 'package:sps_app/screens/notes/note_content.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  //Widget buildSubtitle(BuildContext context);
  Widget buildItem(BuildContext context) {
    return GestureDetector(onTap: () {}, child: buildTitle(context));
  }
}

class ProtocolItem implements ListItem {
  final String protocolTitle;
  final String body;

  ProtocolItem(this.protocolTitle, this.body);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(protocolTitle);
  }

// coverage:ignore-start
  @override
  Widget buildItem(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleProtocolPage(
                    protocolHeading: protocolTitle, protocolContent: body)),
          );
        },
        child: buildTitle(context));
  } // coverage:ignore-end
}

class NotesItem implements ListItem {
  var noteContent = NoteContent();

  NotesItem(int noteID, String title, String body) {
    noteContent.setTitle(title);
    noteContent.setBody(body);
    noteContent.setNoteID(noteID);
  }
  getItemTitle() {
    noteContent.getTitle();
  }

  getItemBody() {
    noteContent.getBody();
  }

// coverage:ignore-start
  @override
  Widget buildTitle(BuildContext context) => Text(noteContent.getTitle(),
      style: const TextStyle(color: Colors.black, fontSize: 18));

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
  } // coverage:ignore-end
}
