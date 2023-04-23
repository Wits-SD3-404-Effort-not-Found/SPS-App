import 'package:flutter/material.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity/connectivity.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: CalendarPage());
  }
}

class _CalendarPageState extends State<CalendarPage> {
  final List<Color> _colorCollection = <Color>[];

  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getAllEventsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SfCalendar(
                    view: CalendarView.month,
                    allowViewNavigation: true,
                    cellBorderColor: Color(0xFFFFFFFF),
                    backgroundColor: Color(0xFFFFFFFF),
                    headerHeight: 60,
                    headerStyle: const CalendarHeaderStyle(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                        backgroundColor: Color(0xFFFFFFFF)),
                    todayHighlightColor: const Color(0xFF043673),
                    monthViewSettings: const MonthViewSettings(
                      navigationDirection: MonthNavigationDirection.vertical,
                      monthCellStyle: MonthCellStyle(
                        textStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      showTrailingAndLeadingDates: false,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                      showAgenda: false,
                      agendaItemHeight: 60,
                      agendaStyle: AgendaStyle(
                          appointmentTextStyle:
                              TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                          backgroundColor: Color(0xFFFFFFFF)),
                    ),
                    dataSource: EventsDataSource(snapshot.data),
                    // by default the month appointment display mode set as Indicator, we can
                    // change the display mode as appointment using the appointment display
                    // mode property
                  ),
                ),
              ));
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}
