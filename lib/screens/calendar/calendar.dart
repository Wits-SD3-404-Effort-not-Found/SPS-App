import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

//initialises the calendar page and is used in the nav bar as one of the pages
class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Align(
              alignment: Alignment.bottomCenter, child: Text('Calendar Page'))),
    );
  }
}
