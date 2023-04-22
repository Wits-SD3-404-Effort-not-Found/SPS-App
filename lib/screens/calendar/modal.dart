import 'package:flutter/material.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ModalScreen extends StatefulWidget {
  const ModalScreen({Key? key}) : super(key: key);

  @override
  ModalScreenState createState() => ModalScreenState();
}

class ModalScreenState extends State<ModalScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2015, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          rowHeight: 60,
          headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF917248),
                  height: 1)),
          daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          daysOfWeekHeight: 20,
          calendarStyle: const CalendarStyle(
            tablePadding: EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }
}
