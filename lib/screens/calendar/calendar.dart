import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:sps_app/screens/calendar/modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:unicons/unicons.dart';

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
  List<Color> _colorCollection = <Color>[];

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    //_initializeEventColor();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getEventsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                  child: SfCalendar(
                    view: CalendarView.month,
                    onSelectionChanged: selectionChanged,
                    selectionDecoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF043673), width: 2)),
                    cellBorderColor: const Color(0xFFFFFFFF),
                    backgroundColor: const Color(0xFFFFFFFF),
                    headerHeight: 60,
                    headerStyle: const CalendarHeaderStyle(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                        backgroundColor: Color(0xFFFFFFFF)),
                    todayHighlightColor: const Color(0xFF043673),
                    monthViewSettings: const MonthViewSettings(
                      navigationDirection: MonthNavigationDirection.vertical,
                      monthCellStyle: MonthCellStyle(
                        textStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
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
                  ),
                ),
              );
            } else {
              return Container(
                child: const Center(
                  child: Text('The Calendar is not fucking working'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void selectionChanged(CalendarSelectionDetails details) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: ModalScreen(
          focusDay: _selectedDate,
        ));
  }

  // Future<List<Meeting>> getDataFromWeb() async {
  //   var data = await http.get(Uri.parse(
  //       "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
  //   var jsonData = json.decode(data.body);

  //   final List<Meeting> appointmentData = [];
  //   final Random random = new Random();
  //   for (var data in jsonData) {
  //     Meeting meetingData = Meeting(
  //         eventName: data['Subject'],
  //         from: _convertDateFromString(
  //           data['StartTime'],
  //         to: _convertDateFromString(data['EndTime']),
  //         background: _colorCollection[random.nextInt(2)],
  //         allDay: data['AllDay']);
  //     appointmentData.add(meetingData);
  //   }
  //   return appointmentData;
  // }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
  }
}

    
// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].allDay;
//   }
// }

// class Meeting {
//   Meeting(
//       {this.eventName,
//       this.from,
//       this.to,
//       this.background,
//       this.allDay = false});

//   String? eventName;
//   DateTime? from;
//   DateTime? to;
//   Color? background;
//   bool? allDay;
// }




