import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/notes/protocol.dart';

class individualScreen extends StatefulWidget {
  const individualScreen({Key? key}) : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<individualScreen> {
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
                  screen: ProtocolScreen()),
            ),
          )
        ],
      ),
    );
  }
}
