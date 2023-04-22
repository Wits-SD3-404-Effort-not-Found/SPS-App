import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/notes/note_content.dart';

class SingleNotePage extends StatefulWidget {
  final NoteContent noteContent;
  const SingleNotePage({Key? key, required this.noteContent}) : super(key: key);

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
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
    widget.noteContent.setBody(_bodyController.text);
    widget.noteContent.setTitle(_titleController.text);
  }

  Future<bool> _autoSave() async {
    widget.noteContent.setBody(_bodyController.text);
    widget.noteContent.setTitle(_titleController.text);
    HTTPManager.putUpdatedNote(widget.noteContent);
    return true;
  }

  @override
  void dispose() {
    _autoSave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xff917248), width: 2))),
              child: Row(children: [
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 30,
                              color: Colors.black,
                            )))),
                Container(
                    height: 60,
                    width: 300,
                    alignment: Alignment.bottomLeft,
                    child: TextField(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      controller: _titleController,
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.left,
                    ))
              ])),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _bodyController),
          )),
        ]));
  }
}
