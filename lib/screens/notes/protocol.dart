import 'package:flutter/material.dart';

class ProtocolScreen extends StatefulWidget {
  const ProtocolScreen({Key? key}) : super(key: key);

  @override
  ProtocolScreenState createState() => ProtocolScreenState();
}

class ProtocolScreenState extends State<ProtocolScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Align(
              alignment: Alignment.bottomCenter, child: Text('Protocol Page'))),
    );
  }
}
