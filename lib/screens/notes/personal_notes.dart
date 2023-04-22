import 'package:flutter/material.dart';
import 'package:sps_app/widgets/primitive/list_item.dart';

class PersonalNotesPage extends StatelessWidget {
  PersonalNotesPage({super.key});
  static var myNoteItem = NotesItem("my note title", "my note content");
  static var myNotesItem_2 = NotesItem("my note title 1", "my note content 1");

  final items = [];

  @override
  Widget build(BuildContext context) {
    items.add(myNoteItem);
    items.add(myNotesItem_2);
    return Scaffold(
        body: Column(children: [
      Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xff917248), width: 2))),
          child: Row(children: [
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                ))
          ])),
      Expanded(
        child: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
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
}
