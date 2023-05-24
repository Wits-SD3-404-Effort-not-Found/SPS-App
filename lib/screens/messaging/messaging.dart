import 'package:flutter/material.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
import 'package:sps_app/http_handler.dart';
import 'communication_item.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({Key? key}) : super(key: key);

  @override
  CommunicationScreenState createState() => CommunicationScreenState();
}

class CommunicationScreenState extends State<CommunicationScreen> {
  var items = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getProfessors(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
                appBar: WitsAppBar(context: context),
                body: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary),
                )
            );
          } else {
            items.clear();
            //checks that the fields are not empty so that there is information to ne displayed
            for (var professor in snapshot.data) {
              if (professor["firstName"] != null &&
                  professor["lastName"] != null &&
                  professor["email"] != null &&
                  professor["cellNumber"] != null) {
                items.add(ProfessorItem(
                    professor["firstName"],
                    professor["lastName"],
                    professor["email"],
                    professor["cellNumber"])
                );
              }
            }
            return Scaffold(
                appBar: WitsAppBar(context: context),
                body: Column(
                  children: <Widget>[
                    Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 2)
                            )
                        ),
                        child: Row(children: [
                          const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                              )
                          ),
                          Container(
                              height: 60,
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Professors",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    Theme.of(context).colorScheme.onBackground),
                                textAlign: TextAlign.left,
                              )
                          )
                        ])
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        // Let the ListView know how many items it needs to build.
                        itemCount: items.length,
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (BuildContext context, int index) {
                          final item = items[index];
                          return ListTile(
                            horizontalTitleGap: 0,
                            title: item.buildItem(context),
                          );
                        },
                      ),
                    )
                  ],
                )
            );
          }
        });
  } // coverage:ignore-end
}
