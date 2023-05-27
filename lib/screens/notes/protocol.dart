import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
import '../../widgets/primitive/list_item.dart';

class ProtocolScreen extends StatefulWidget {
  const ProtocolScreen({Key? key}) : super(key: key);

  @override
  ProtocolScreenState createState() => ProtocolScreenState();
}

class ProtocolScreenState extends State<ProtocolScreen> {
  var items = [];
  // coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getProtocols(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
                appBar: WitsAppBar(context: context),
                body: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary),
                ));
          } else {
            items.clear();
            for (var protocol in snapshot.data) {
              if (protocol["protocolTitle"] != null &&
                  protocol["protocolContent"] != null) {
                items.add(ProtocolItem(
                    protocol["protocolTitle"], protocol["protocolContent"]));
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 2))),
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
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      )))),
                          Container(
                              height: 50,
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Protocols",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                textAlign: TextAlign.left,
                              ))
                        ])),
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
                ));
          }
        });
  } // coverage:ignore-end
}
