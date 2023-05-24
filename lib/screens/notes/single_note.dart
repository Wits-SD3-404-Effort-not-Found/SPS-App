import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/notes/note_content.dart';
import 'package:sps_app/widgets/primitive/public_note_menu_item.dart';

enum SampleItem { itemOne, itemTwo }

enum Commands { publicNote }

class SingleNotePage extends StatefulWidget {
  final NoteContent noteContent;
  const SingleNotePage({Key? key, required this.noteContent}) : super(key: key);

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

// coverage:ignore-start
class _SingleNotePageState extends State<SingleNotePage> {
  var publicNoteMenuItemController = PublicNoteMenuItemController();
  var _bodyController = TextEditingController();
  var _titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _bodyController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.noteContent.getBody(),
      ),
    );
    _titleController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.noteContent.getTitle(),
      ),
    );
    publicNoteMenuItemController.value = widget.noteContent.getIsPublicNote();
    widget.noteContent.setBody(_bodyController.text);
    widget.noteContent.setTitle(_titleController.text);
    widget.noteContent.setIsPublicNote(publicNoteMenuItemController.value);
  }

  Future<bool> _autoSave() async {
    widget.noteContent.setBody(_bodyController.text);
    widget.noteContent.setTitle(_titleController.text);
    widget.noteContent.setIsPublicNote(publicNoteMenuItemController.value);
    debugPrint("value from controller");
    debugPrint(publicNoteMenuItemController.value.toString());
    debugPrint("value from note content");
    debugPrint(widget.noteContent.getIsPublicNote().toString());
    if (widget.noteContent.isNewNote) {
      HTTPManager.postNewNote(widget.noteContent);
    } else {
      HTTPManager.putUpdatedNote(widget.noteContent);
    }
    return true;
  }

  @override
  void dispose() {
    _autoSave();
    super.dispose();
  }

  SampleItem? selectedMenu;
  Commands? commandsMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
          Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )))),
                    Container(
                        height: 60,
                        width: 270,
                        alignment: Alignment.bottomLeft,
                        child: TextField(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: _titleController,
                          style: TextStyle(
                              fontSize: 30,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          textAlign: TextAlign.left,
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: PopupMenuButton<Commands>(
                              icon: Icon(
                                Icons.keyboard_control_rounded,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              iconSize: 30,
                              color: Theme.of(context).colorScheme.background,
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<Commands>>[
                                PopupMenuItem<Commands>(
                                    child: PublicNoteMenuItem(
                                        controller:
                                            publicNoteMenuItemController)),
                                PopupMenuItem<Commands>(
                                  child: Text('Delete Note',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 17)),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              title: Text(
                                                "Delete Note",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                              ),
                                              content: Text(
                                                "Are you sure you want to delete this note?.",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground),
                                                  ),
                                                  onPressed: () {
                                                    HTTPManager.deleteNote(
                                                        widget.noteContent);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ]);
                                        });
                                  },
                                ),
                                // ...other items listed here
                              ],
                            )))
                  ])),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                decoration: const InputDecoration(border: InputBorder.none),
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _bodyController),
          )),
        ]));
  } // coverage:ignore-end
}
