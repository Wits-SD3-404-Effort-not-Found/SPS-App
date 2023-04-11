import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/single_note.dart';
import 'package:sps_app/screens/notes/single_protocol.dart';

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

  @override
  Widget buildItem(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleProtocolPage(protocolContent: body)),
          );
        },
        child: buildTitle(context));
  }
}

class NotesItem implements ListItem {
  final String noteTitle;
  final String body;

  NotesItem(this.noteTitle, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(noteTitle);

  @override
  Widget buildItem(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNotePage(noteContent: body)),
          );
        },
        child: buildTitle(context));
  }
}
