import 'package:flutter/material.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'manager.dart';

class ModalScreen extends StatefulWidget {
  final DateTime focusDay;
  const ModalScreen({Key? key, required this.focusDay}) : super(key: key);

  @override
  ModalScreenState createState() => ModalScreenState(focusDay: this.focusDay);
}

class ModalScreenState extends State<ModalScreen> {
  DateTime focusDay;
  ModalScreenState({required this.focusDay});

  late final ValueNotifier<List<Events>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  List<Events> _getEventsForDay(DateTime date) {
    return allEvents[date] ?? [];
  }

  List<Events> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  final eventsList = getEventsModalData();

  @override
  void initState() {
    _focusedDay = focusDay;
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    allTheEvents(eventsList);
    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _selectedEvents.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            //future:HTTPManager.getAllEventsData() ,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TableCalendar<Events>(
                    eventLoader: _getEventsForDay,
                    focusedDay: focusDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    rangeSelectionMode: _rangeSelectionMode,
                    onRangeSelected: _onRangeSelected,
                    onDaySelected: _onDaySelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
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
                  SizedBox(height: 8.0),
                  Expanded(
                      child: ValueListenableBuilder<List<Events>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ListTile(
                                      onTap: () => '${value[index]}',
                                      minVerticalPadding: 18.0,
                                      dense: true,
                                      title: Text(
                                        '${value[index].eventName}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        '${value[index].description}\n${value[index].startDate} to ${value[index].endDate}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      isThreeLine: true,
                                      tileColor: Colors.lightBlue,
                                    ),
                                  );
                                });
                          })),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
