import 'package:flutter/material.dart';
import 'package:sps_app/screens/notes/personal_notes.dart';
import 'package:sps_app/screens/notes/protocol.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Notes',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
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
                              side: BorderSide(
                                  width: 3,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Protocols',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 22),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
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
                              side: BorderSide(
                                  width: 3,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Personal Notes',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 22),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ])))),
            ]),
          )
        ]));
  } // coverage:ignore-end
}
