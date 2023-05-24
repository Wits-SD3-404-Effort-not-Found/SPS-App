import 'package:flutter/material.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

//initialises the calendar page and is used in the nav bar as one of the pages
class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WitsAppBar(context: context),
      backgroundColor: Colors.white,
      body: const Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Messaging Page'))),
    );
  }
}
