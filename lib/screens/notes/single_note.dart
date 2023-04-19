import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/note_content.dart';
import 'package:sps_app/screens/notes/personal_notes.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 40), // just for now for testing, bc top bar not here
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xff917248), width: 2))),
              child: Row(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        onTap: () {
                          widget.noteContent.setBody(_bodyController.text);
                          widget.noteContent.setTitle(_titleController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalNotesPage()));
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25,
                          color: Colors.black,
                        ))),
                ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(300, 50)),
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

/* Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),*/

/*                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalNotesPage()));
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.black,
                      )),*/
