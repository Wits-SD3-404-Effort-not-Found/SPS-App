import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ModalScreen extends StatefulWidget {
  const ModalScreen({Key? key}) : super(key: key);

  @override
  ModalScreenState createState() => ModalScreenState();
}

class ModalScreenState extends State<ModalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EventCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarOptions: CalendarOptions(viewType: ViewType.DAILY),
          calendarLanguage: 'en',
        ),
      ),
    );
  }
}
