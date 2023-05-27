import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/widgets/complex/event_popup.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
//import 'package:sps_app/account_manager.dart';
//import 'package:sps_app/http_handler.dart';
//import 'package:sps_app/screens/calendar/calendar.dart'; //this is needed
import 'package:table_calendar/table_calendar.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';

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
  EventPopupController newEventController = EventPopupController();
  EventPopupController editEventController = EventPopupController();

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
    _selectedEvents.value = ModalManager.getEventsForDay(focusDay); //
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

//coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WitsAppBar(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              Card(
                  elevation: 20,
                  borderOnForeground: true,
                  margin: const EdgeInsets.all(0.05),
                  color: Theme.of(context).colorScheme.background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        color: Theme.of(context).colorScheme.background,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Theme.of(context).colorScheme.onBackground,
                            size: 30,
                          ),
                        ),
                      ),
                      Text("Daily Schedule",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      Container(
                          height: 50,
                          width: 50,
                          color: Theme.of(context).colorScheme.background,
                          alignment: Alignment.centerRight,
                          // popup code for adding an event
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EventsPopup(
                                      'New Event', newEventController, () {
                                    final addStartDateTime = DateTime(
                                        newEventController.startDate.year,
                                        newEventController.startDate.month,
                                        newEventController.startDate.day,
                                        newEventController.startTime.hour,
                                        newEventController.startTime.minute);
                                    final addEndDateTime = DateTime(
                                        newEventController.endDate.year,
                                        newEventController.endDate.month,
                                        newEventController.endDate.day,
                                        newEventController.endTime.hour,
                                        newEventController.endTime.minute);
                                    final newEvent = Events(
                                        eventId: 0,
                                        startDate: addStartDateTime,
                                        endDate: addEndDateTime,
                                        eventName: newEventController
                                            .nameController.text,
                                        description: newEventController
                                            .descriptionController.text);
                                    HTTPManager.postNewEvent(newEvent);
                                    Navigator.of(context).pop();
                                  });
                                },
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.onBackground,
                              size: 34,
                            ),
                          ))
                    ],
                  )),
              Card(
                elevation: 20,
                borderOnForeground: true,
                margin: const EdgeInsets.all(0.2),
                color: Theme.of(context).colorScheme.background,
                child: TableCalendar<Events>(
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
                  // rangeSelectionMode: _rangeSelectionMode,
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
                  headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 28,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 28,
                      )),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          height: 1,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(
                          height: 1,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle),
                      defaultTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground)),
                ),
              ),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: _selectedEvents.value.length,
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
                                    //onTap: () =>
                                    //    '${ModalManager.allEvents[_selectedDay]![index]}',
                                    minVerticalPadding: 18.0,
                                    dense: true,
                                    title: Text(
                                      '${ModalManager.allEvents[_selectedDay]![index].eventName}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${ModalManager.allEvents[_selectedDay]![index].description}\n${ModalManager.allEvents[_selectedDay]![index].startDate.toString().substring(0, 16)} to ${ModalManager.allEvents[_selectedDay]![index].endDate.toString().substring(0, 16)}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    isThreeLine: true,
                                    tileColor: ModalManager
                                        .allEvents[_selectedDay]![index]
                                        .background,
                                    trailing: !isRotation(ModalManager
                                            .allEvents[_selectedDay]![index])
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                // popup code for edit an event
                                                GestureDetector(
                                                  onTap: () {
                                                    editEventController
                                                            .nameController =
                                                        TextEditingController
                                                            .fromValue(
                                                      TextEditingValue(
                                                        text: ModalManager
                                                            .allEvents[
                                                                _selectedDay]![
                                                                index]
                                                            .eventName
                                                            .toString(),
                                                      ),
                                                    );
                                                    editEventController
                                                            .descriptionController =
                                                        TextEditingController
                                                            .fromValue(
                                                      TextEditingValue(
                                                        text: ModalManager
                                                            .allEvents[
                                                                _selectedDay]![
                                                                index]
                                                            .description
                                                            .toString(),
                                                      ),
                                                    );
                                                    editEventController
                                                            .startTime =
                                                        TimeOfDay(
                                                            hour: ModalManager
                                                                .allEvents[
                                                                    _selectedDay]![
                                                                    index]
                                                                .startDate
                                                                .hour,
                                                            minute: ModalManager
                                                                .allEvents[
                                                                    _selectedDay]![
                                                                    index]
                                                                .startDate
                                                                .minute);
                                                    editEventController
                                                            .endTime =
                                                        TimeOfDay(
                                                            hour: ModalManager
                                                                .allEvents[
                                                                    _selectedDay]![
                                                                    index]
                                                                .endDate
                                                                .hour,
                                                            minute: ModalManager
                                                                .allEvents[
                                                                    _selectedDay]![
                                                                    index]
                                                                .endDate
                                                                .minute);
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return EventsPopup(
                                                              'Edit Event',
                                                              editEventController,
                                                              () {
                                                            final editStartDateTime = DateTime(
                                                                editEventController
                                                                    .startDate
                                                                    .year,
                                                                editEventController
                                                                    .startDate
                                                                    .month,
                                                                editEventController
                                                                    .startDate
                                                                    .day,
                                                                editEventController
                                                                    .startTime
                                                                    .hour,
                                                                editEventController
                                                                    .startTime
                                                                    .minute);
                                                            final editEndDateTime = DateTime(
                                                                editEventController
                                                                    .endDate
                                                                    .year,
                                                                editEventController
                                                                    .endDate
                                                                    .month,
                                                                editEventController
                                                                    .endDate
                                                                    .day,
                                                                editEventController
                                                                    .endTime
                                                                    .hour,
                                                                editEventController
                                                                    .endTime
                                                                    .minute);
                                                            final editedEvent = Events(
                                                                eventId: ModalManager
                                                                    .allEvents[
                                                                        _selectedDay]![
                                                                        index]
                                                                    .eventId,
                                                                startDate:
                                                                    editStartDateTime,
                                                                endDate:
                                                                    editEndDateTime,
                                                                eventName:
                                                                    editEventController
                                                                        .nameController
                                                                        .text,
                                                                description:
                                                                    editEventController
                                                                        .descriptionController
                                                                        .text);
                                                            HTTPManager
                                                                .putEditedEvent(
                                                                    editedEvent);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: 30,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),

                                                // pop up code for delete event
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                            title: Text(
                                                              "Delete Event",
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground),
                                                            ),
                                                            content: Text(
                                                              "Are you sure you want to delete this event?",
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground)),
                                                                onPressed: () {
                                                                  HTTPManager.deleteEvent(ModalManager
                                                                      .allEvents[
                                                                          _selectedDay]![
                                                                          index]
                                                                      .eventId);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    size: 30,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                )
                                              ])
                                        : null,
                                  ));
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
  //coverage:ignore-end
}

//create a function that checks if its a rotation
bool isRotation(Events event) {
  if (event is Rotations) {
    return true;
  }
  return false;
}
