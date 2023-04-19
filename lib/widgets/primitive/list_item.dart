import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/single_note.dart';
import 'package:sps_app/screens/notes/single_protocol.dart';

import '../../screens/notes/note_content.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  //Widget buildSubtitle(BuildContext context);
  Widget buildItem(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: () {}, child: buildTitle(context)),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xff917248), width: 3.0))),
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
        style: const TextStyle(color: Colors.black, fontSize: 18));
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
                    builder: (context) =>
                        SingleProtocolPage(protocolHeading: protocolTitle, protocolContent: body)),
              );
            },
            child: Stack(children: [
              buildTitle(context),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xff917248), width: 2))),
              ),
            ])));
  }
}

class NotesItem implements ListItem {
  var noteContent = NoteContent();

  NotesItem(String title, String body) {
    noteContent.setTitle(title);
    noteContent.setBody(body);
  }

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
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xff917248), width: 2))),
              ),
            ])));
  }
}
