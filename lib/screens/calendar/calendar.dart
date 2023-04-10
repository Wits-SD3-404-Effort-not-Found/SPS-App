import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

//initialises the calendar page and is used in the nav bar as one of the pages
class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Calendar', home: ScrollableCalendar());
  }
}

class ScrollableCalendar extends StatelessWidget {
  final calendarController = CleanCalendarController(
    minDate: DateTime.now().subtract(Duration(days: 365)),
    maxDate: DateTime.now().add(const Duration(days: 365)),
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {},
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
    // initialDateSelected: DateTime(2022, 2, 3),
    // endDateSelected: DateTime(2022, 2, 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: ScrollableCleanCalendar(
        calendarController: calendarController,
        layout: Layout.DEFAULT,
        calendarCrossAxisSpacing: 0,
        spaceBetweenMonthAndCalendar: 20,
        monthTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        monthTextAlign: TextAlign.left,
        daySelectedBackgroundColor: Color(0xFF917248),
        dayBackgroundColor: Color(0xFFFFFFFF),
        dayRadius: 30,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      ),
    );
  }
}
