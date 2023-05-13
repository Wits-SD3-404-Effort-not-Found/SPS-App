import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
//import 'package:sps_app/account_manager.dart';
//import 'package:sps_app/http_handler.dart';
//import 'package:sps_app/screens/calendar/calendar.dart'; //this is needed
import 'package:table_calendar/table_calendar.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
//import 'package:unicons/unicons.dart';

class ModalScreen extends StatefulWidget {
  final DateTime focusDay;
  final Future<List<Events>> data;

  const ModalScreen({Key? key, required this.focusDay, required this.data})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ModalScreenState createState() =>
      // ignore: no_logic_in_create_state
      ModalScreenState(focusDay: focusDay, data: data);
}

class ModalScreenState extends State<ModalScreen> {
  DateTime focusDay;
  Future<List<Events>> data;
  ModalScreenState({required this.focusDay, required this.data});

  late final ValueNotifier<List<Events>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  List<Events> _getEventsForRange(DateTime start, DateTime end) {
    final days = ModalManager.daysInRange(start, end);

    return [
      for (final d in days) ...ModalManager.getEventsForDay(d),
    ];
  }

//when you select a day in the table calendar
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedEvents.value = ModalManager.getEventsForDay(selectedDay);
    });
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = ModalManager.getEventsForDay(selectedDay);
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
      _selectedEvents.value = ModalManager.getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = ModalManager.getEventsForDay(end);
    }
  }

  //converts Future<List<Events>> to List<Events> and populates allEvents
  void getEvents() async {
    List<Events> events = await data;
    ModalManager.allTheEvents(
        events); //populates allEvents Method with List<Events> through allTheEvents method
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = focusDay;
    _selectedDay = _focusedDay;
    getEvents();
    _selectedEvents =
        ValueNotifier(ModalManager.getEventsForDay(_selectedDay!));
    _selectedEvents.value = ModalManager.getEventsForDay(focusDay);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _selectedEvents.value.clear();
    ModalManager.allEvents.clear();
    // This is to clear duplication of events in the modal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TableCalendar<Events>(
                eventLoader: ModalManager.getEventsForDay,
                focusedDay: focusDay,
                onPageChanged: (focusedDay) {
                  //focuses on new selected day
                  focusDay = focusedDay;
                  _focusedDay = focusDay;
                },
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
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _selectedEvents.value.length, //
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: ListTile(
                          onTap: () =>
                              '${ModalManager.allEvents[_selectedDay]![index]}',
                          minVerticalPadding: 18.0,
                          dense: true,
                          title: Text(
                            '${ModalManager.allEvents[_selectedDay]![index].eventName}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${ModalManager.allEvents[_selectedDay]![index].description}\n${ModalManager.allEvents[_selectedDay]![index].startDate.toString()} to ${ModalManager.allEvents[_selectedDay]![index].endDate.toString()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          isThreeLine: true,
                          tileColor: ModalManager
                              .allEvents[_selectedDay]![index].background,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Delete Event"),
                                          content: const Text(
                                              "Are you sure you want to delete this event?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("Delete"),
                                              onPressed: () {
                                                if (isRotation(ModalManager
                                                        .allEvents[
                                                    _selectedDay]![index])) {
                                                  //checks if rotation
                                                  //put alert dialog that cant delete
                                                } else {
                                                  HTTPManager.deleteEvent(
                                                      ModalManager
                                                          .allEvents[
                                                              _selectedDay]![
                                                              index]
                                                          .eventId);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(
                                  Icons.delete_forever,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

//create a function that checks if its a rotation
bool isRotation(Events event) {
  if (event is Rotations) {
    return true;
  }
  return false;
}
