import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/notes/protocol.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  @override
  IndividualScreenState createState() => IndividualScreenState();
}

class IndividualScreenState extends State<IndividualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text("protocol page"),
              onPressed: () => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const ProtocolScreen()),
            ),
          )
        ],
      ),
    );
  }
}
