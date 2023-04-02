import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Messaging Page'))),
    );
  }
}
