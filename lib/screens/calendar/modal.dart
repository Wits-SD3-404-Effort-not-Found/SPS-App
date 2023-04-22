import 'package:flutter/material.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'manager.dart';

class ModalScreen extends StatefulWidget {
  const ModalScreen({Key? key}) : super(key: key);

  @override
  ModalScreenState createState() => ModalScreenState();
}

class ModalScreenState extends State<ModalScreen> {
  late final ValueNotifier<List<Events>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<Events> getEventsForDay(DateTime date) {
    return allEvents[date] ?? [];
  }

  List<Events> getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, _focusedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });
      _selectedEvents.value = getEventsForDay(selectedDay); //not populating
    }
  }

  final eventsList = getEventsModalData();

  @override
  void initState() {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay));
    allTheEvents(eventsList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(color: Color(0xFF043673), width: 2.0),
            ),
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2015, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: CalendarFormat.week,
              rowHeight: 60,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Color(0xFF917248),
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Color(0xFF917248),
                    size: 28,
                  )),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(
                      color: Color(0xFF917248),
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: Color(0xFF043673), shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: Color(0xFF917248), shape: BoxShape.circle)),
            ),
          ),
        ],
      ),
    );
  }
}
