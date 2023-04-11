import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.month,
      cellBorderColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xFFFFFFFF),
      headerHeight: 60,
      headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          backgroundColor: Color(0xFFFFFFFF)),
      todayHighlightColor: Color(0xFF043673),
      monthViewSettings: const MonthViewSettings(
        navigationDirection: MonthNavigationDirection.vertical,
        monthCellStyle: MonthCellStyle(
          textStyle: TextStyle(
              fontStyle: FontStyle.normal, fontSize: 15, color: Colors.black),
        ),
        showTrailingAndLeadingDates: false,
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        showAgenda: true,
        agendaItemHeight: 60,
        agendaStyle: const AgendaStyle(
            appointmentTextStyle:
                TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
            backgroundColor: Color(0xFFFFFFFF)),
      ),
      dataSource: MeetingDataSource(_getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
    ));
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
  final DateTime endTime = startTime.add(const Duration(hours: 4));
  meetings.add(
      Meeting('Hello', startTime, endTime, Color.fromARGB(255, 211, 25, 214)));
  meetings.add(Meeting(
      'Rotation', startTime, endTime, Color.fromARGB(255, 19, 223, 169)));
  return meetings;
}

// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
    this.eventName,
    this.from,
    this.to,
    this.background,
  );

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;
}
