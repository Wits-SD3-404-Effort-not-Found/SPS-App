import 'package:flutter/material.dart';
import 'package:sps_app/widgets/primitive/list_item.dart';
import '../../http_handler.dart';

class PersonalNotesPage extends StatefulWidget {
  const PersonalNotesPage({super.key});
  @override
  State<PersonalNotesPage> createState() => PersonalNotesPageState();
}

class PersonalNotesPageState extends State<PersonalNotesPage> {
  var items = [];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

class _PersonalNotesPageState extends State<PersonalNotesPage> {
  var items = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getNotes(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff917248),
                  ),
                ));
          } else {
            items.clear();
            for (var note in snapshot.data) {
              if (note["noteID"] != null &&
                  note["noteTitle"] != null &&
                  note["noteContent"] != null) {
                items.add(NotesItem(
                    note["noteID"], note["noteTitle"], note["noteContent"]));
              }
            }
            return Scaffold(
                body: Column(children: [
              Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xff917248), width: 2))),
                  child: Row(children: [
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30,
                                  color: Colors.black,
                                )))),
                    Container(
                        height: 50,
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Personal Notes",
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.left,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(
                                  Icons.refresh,
                                  size: 30,
                                  color: Colors.black,
                                )))),
                  ])),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  // Let the ListView know how many items it needs to build.
                  itemCount: items.length,
                  // Provide a builder function.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return ListTile(
                      horizontalTitleGap: 0,
                      minVerticalPadding: 5,
                      title: item.buildItem(context),
                    );
                  },
                ),
              )
            ]));
          }
        });
  }
}
