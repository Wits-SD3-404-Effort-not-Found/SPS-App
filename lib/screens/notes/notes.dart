import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/personal_notes.dart';
import 'package:sps_app/screens/notes/protocol.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(children: [
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(360, 60)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProtocolScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                              side: const BorderSide(color: Color(0xff043673))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Protocols',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ])))),
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(360, 60)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalNotesPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                              side: const BorderSide(color: Color(0xff043673))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Personal Notes',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ])))),
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(360, 60)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              side: const BorderSide(color: Color(0xff043673))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Logbook',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ])))),
            ]),
          )
        ]));
  }
}
