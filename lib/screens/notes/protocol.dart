import 'package:flutter/material.dart';
import '../../widgets/primitive/list_item.dart';

class ProtocolScreen extends StatefulWidget {
  const ProtocolScreen({Key? key}) : super(key: key);

  @override
  ProtocolScreenState createState() => ProtocolScreenState();
}

class ProtocolScreenState extends State<ProtocolScreen> {
  final List<ListItem> items = [
    ProtocolItem("Example Protocol", "Run burn wound under cold water. keep under water until its cooled down"),
    ProtocolItem("Gun", "call the MF-ing Police"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff917248), width: 2)
                )
            ),
            child: const Text(
              "Protocols", style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top:10),
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
}
