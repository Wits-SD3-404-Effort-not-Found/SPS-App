import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class individualScreen extends StatefulWidget {
  const individualScreen({Key? key}) : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<individualScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Notes individual Page'))),
    );
  }
}
