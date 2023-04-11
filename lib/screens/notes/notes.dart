import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:sps_app/screens/notes/personal_notes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(children: [
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(250, 50)),
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff043673))),
                      child: Row(children: const [
                        Text(
                          'Protocols',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 45,
                          color: Colors.black,
                        ),
                      ]))),
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(250, 50)),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalNotesPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff043673))),
                      child: Row(children: const [
                        Text(
                          'Notes',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 45,
                          color: Colors.black,
                        ),
                      ]))),
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(250, 50)),
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff043673))),
                      child: Row(children: const [
                        Text(
                          'Logbook',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 45,
                          color: Colors.black,
                        ),
                      ]))),
            ]),
          )
        ]));
  }
}
