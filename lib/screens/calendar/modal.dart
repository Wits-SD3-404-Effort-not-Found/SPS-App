import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
//import 'package:sps_app/account_manager.dart';
//import 'package:sps_app/http_handler.dart';
//import 'package:sps_app/screens/calendar/calendar.dart'; //this is needed
import 'package:table_calendar/table_calendar.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  DateTime _newStartDate = DateTime.now();
  DateTime _newEndDate = DateTime.now();
  DateTime _editStartDate = DateTime.now();
  DateTime _editEndDate = DateTime.now();
  TimeOfDay _newStartTime = TimeOfDay.now();
  TimeOfDay _newEndTime = TimeOfDay.now();
  TimeOfDay _editStartTime = TimeOfDay.now();
  TimeOfDay _editEndTime = TimeOfDay.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  final addEventNameController = TextEditingController();
  final addEventDescriptionController = TextEditingController();
  var _editEventNameController = TextEditingController();
  var _editEventDescriptionController = TextEditingController();

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
        _newStartDate = focusedDay;
        _newEndDate = focusedDay;
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
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
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
    _newStartDate = _focusedDay;
    _newEndDate = _focusedDay;
    getEvents();
    _selectedEvents =
        ValueNotifier(ModalManager.getEventsForDay(_selectedDay!));
    _selectedEvents.value = ModalManager.getEventsForDay(focusDay);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _selectedEvents.value.clear();
    addEventDescriptionController.dispose();
    addEventNameController.dispose();
    _editEventDescriptionController.dispose();
    _editEventNameController.dispose();
    ModalManager.allEvents.clear();
    // This is to clear duplication of events in the modal
    super.dispose();
  }

  void _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      setState(() {
        _newStartTime = newTime;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      helpText: "",
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      setState(() {
        _newEndTime = newTime;
      });
    }
  }

  void _selectEditStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      setState(() {
        _editStartTime = newTime;
      });
    }
  }

  void _selectEditEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      helpText: "",
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      setState(() {
        _editEndTime = newTime;
      });
    }
  }

  void selectionChanged(
      DateRangePickerSelectionChangedArgs selectionChangedArgs) {
    _newStartDate = selectionChangedArgs.value.startDate;
    _newEndDate = selectionChangedArgs.value.endDate;
  }

  void editSelectionChanged(
      DateRangePickerSelectionChangedArgs selectionChangedArgs) {
    _editStartDate = selectionChangedArgs.value.startDate;
    _editEndDate = selectionChangedArgs.value.endDate;
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
                                  return SimpleDialog(
                                    title: const Text("New Event"),
                                    children: [
                                      Column(children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            // constrained box to encapsulate user input text box
                                            child: ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tight(
                                                        const Size(275, 50)),
                                                child: TextFormField(
                                                    // styles user input text box
                                                    decoration: InputDecoration(
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 1.5)),
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 1.5)),
                                                      hintText: 'Event Name',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 14),
                                                    ),
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    // to retrieve the user input text from the TextFormField
                                                    controller:
                                                        addEventNameController))),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            // constrained box to encapsulate user input text box
                                            child: ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tight(
                                                        const Size(275, 50)),
                                                child: TextFormField(
                                                    // styles user input text box
                                                    decoration: InputDecoration(
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 1.5)),
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 1.5)),
                                                      hintText:
                                                          'Event Description',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 14),
                                                    ),
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    // to retrieve the user input text from the TextFormField
                                                    controller:
                                                        addEventDescriptionController))),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30,
                                                    top: 30,
                                                    right: 30,
                                                    bottom: 8),
                                                child: Text(
                                                  "Select start and end dates:",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ))),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: SizedBox(
                                              height: 300,
                                              width: 275,
                                              child: SfDateRangePicker(
                                                initialDisplayDate: _focusedDay,
                                                initialSelectedRange:
                                                    PickerDateRange(_focusedDay,
                                                        _focusedDay),
                                                startRangeSelectionColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                endRangeSelectionColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                rangeSelectionColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                view: DateRangePickerView.month,
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .range,
                                                onSelectionChanged:
                                                    selectionChanged,
                                              ),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Start time:',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .surface,
                                                      fixedSize:
                                                          const Size(100, 3)),
                                                  onPressed: _selectStartTime,
                                                  child: Text(
                                                    _newStartTime
                                                        .format(context),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('End time:',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .surface,
                                                      fixedSize:
                                                          const Size(100, 3)),
                                                  onPressed: _selectEndTime,
                                                  child: Text(
                                                    _newEndTime.format(context),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                addEventNameController.clear();
                                                addEventDescriptionController
                                                    .clear();
                                                _newStartTime = TimeOfDay.now();
                                                _newEndTime = TimeOfDay.now();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Confirm",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onBackground)),
                                              onPressed: () {
                                                final addStartDateTime =
                                                    DateTime(
                                                        _newStartDate.year,
                                                        _newStartDate.month,
                                                        _newStartDate.day,
                                                        _newStartTime.hour,
                                                        _newStartTime.minute);
                                                final addEndDateTime = DateTime(
                                                    _newEndDate.year,
                                                    _newEndDate.month,
                                                    _newEndDate.day,
                                                    _newEndTime.hour,
                                                    _newEndTime.minute);
                                                final newEvent = Events(
                                                    eventId: 0,
                                                    startDate: addStartDateTime,
                                                    endDate: addEndDateTime,
                                                    eventName:
                                                        addEventNameController
                                                            .text,
                                                    description:
                                                        addEventDescriptionController
                                                            .text);
                                                HTTPManager.postNewEvent(
                                                    newEvent);
                                                Navigator.of(context).pop();
                                                addEventNameController.clear();
                                                addEventDescriptionController
                                                    .clear();
                                                _newStartTime = TimeOfDay.now();
                                                _newEndTime = TimeOfDay.now();
                                              },
                                            ),
                                          ])
                                    ],
                                  );
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
                          color: Theme.of(context).colorScheme.onSurface,
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
                                    trailing:
                                        !isRotation(ModalManager.allEvents[
                                                _selectedDay]![index])
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                    // popup code for edit an event
                                                    GestureDetector(
                                                      onTap: () {
                                                        _editEventNameController =
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
                                                        _editEventDescriptionController =
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
                                                        _editStartTime = TimeOfDay(
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
                                                        _editEndTime = TimeOfDay(
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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return SimpleDialog(
                                                                title: const Text(
                                                                    "Edit Event"),
                                                                children: [
                                                                  Column(
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                                            // constrained box to encapsulate user input text box
                                                                            child: ConstrainedBox(
                                                                                constraints: BoxConstraints.tight(const Size(275, 50)),
                                                                                child: TextFormField(
                                                                                    // styles user input text box
                                                                                    decoration: const InputDecoration(
                                                                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff917248), width: 1.5)),
                                                                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff917248), width: 1.5)),
                                                                                      hintText: 'Event Name',
                                                                                      hintStyle: TextStyle(fontSize: 14),
                                                                                    ),
                                                                                    cursorColor: const Color(0xff917248),
                                                                                    // to retrieve the user input text from the TextFormField
                                                                                    controller: _editEventNameController))),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                                            // constrained box to encapsulate user input text box
                                                                            child: ConstrainedBox(
                                                                                constraints: BoxConstraints.tight(const Size(275, 50)),
                                                                                child: TextFormField(
                                                                                    // styles user input text box
                                                                                    decoration: const InputDecoration(
                                                                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff917248), width: 1.5)),
                                                                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff917248), width: 1.5)),
                                                                                      hintText: 'Event Description',
                                                                                      hintStyle: TextStyle(fontSize: 14),
                                                                                    ),
                                                                                    cursorColor: const Color(0xff917248),
                                                                                    // to retrieve the user input text from the TextFormField
                                                                                    controller: _editEventDescriptionController))),
                                                                        const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child: Padding(
                                                                                padding: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 8),
                                                                                child: Text(
                                                                                  "Select start and end dates:",
                                                                                  style: TextStyle(fontSize: 18),
                                                                                ))),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                            child: SizedBox(
                                                                              height: 300,
                                                                              width: 275,
                                                                              child: SfDateRangePicker(
                                                                                initialDisplayDate: _focusedDay,
                                                                                initialSelectedRange: PickerDateRange(ModalManager.allEvents[_selectedDay]![index].startDate, ModalManager.allEvents[_selectedDay]![index].endDate),
                                                                                startRangeSelectionColor: const Color(0xFF043673),
                                                                                endRangeSelectionColor: const Color(0xFF043673),
                                                                                rangeSelectionColor: const Color.fromRGBO(4, 54, 115, 0.3),
                                                                                view: DateRangePickerView.month,
                                                                                selectionMode: DateRangePickerSelectionMode.range,
                                                                                onSelectionChanged: editSelectionChanged,
                                                                              ),
                                                                            )),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text('Start time:', style: TextStyle(fontSize: 18)),
                                                                                TextButton(
                                                                                  style: TextButton.styleFrom(backgroundColor: Colors.grey[400], fixedSize: const Size(100, 3)),
                                                                                  onPressed: _selectEditStartTime,
                                                                                  child: Text(
                                                                                    _editStartTime.format(context),
                                                                                    style: const TextStyle(color: Colors.black, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text('End time:', style: TextStyle(fontSize: 18)),
                                                                                TextButton(
                                                                                  style: TextButton.styleFrom(backgroundColor: Colors.grey[400], fixedSize: const Size(100, 3)),
                                                                                  onPressed: _selectEditEndTime,
                                                                                  child: Text(
                                                                                    _editEndTime.format(context),
                                                                                    style: const TextStyle(color: Colors.black, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ]),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        TextButton(
                                                                          child:
                                                                              const Text(
                                                                            "Cancel",
                                                                            style:
                                                                                TextStyle(fontSize: 16, color: Colors.black),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            _editEventNameController.clear();
                                                                            _editEventDescriptionController.clear();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: const Text(
                                                                              "Confirm",
                                                                              style: TextStyle(fontSize: 16, color: Colors.black)),
                                                                          onPressed:
                                                                              () {
                                                                            final editStartDateTime = DateTime(
                                                                                _editStartDate.year,
                                                                                _editStartDate.month,
                                                                                _editStartDate.day,
                                                                                _editStartTime.hour,
                                                                                _editStartTime.minute);
                                                                            final editEndDateTime = DateTime(
                                                                                _editEndDate.year,
                                                                                _editEndDate.month,
                                                                                _editEndDate.day,
                                                                                _editEndTime.hour,
                                                                                _editEndTime.minute);
                                                                            final editedEvent = Events(
                                                                                eventId: ModalManager.allEvents[_selectedDay]![index].eventId,
                                                                                startDate: editStartDateTime,
                                                                                endDate: editEndDateTime,
                                                                                eventName: _editEventNameController.text,
                                                                                description: _editEventDescriptionController.text);
                                                                            HTTPManager.putEditedEvent(editedEvent);
                                                                            Navigator.of(context).pop();
                                                                            _editEventNameController.clear();
                                                                            _editEventDescriptionController.clear();
                                                                          },
                                                                        ),
                                                                      ])
                                                                ],
                                                              );
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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                                title: const Text(
                                                                    "Delete Event"),
                                                                content: const Text(
                                                                    "Are you sure you want to delete this event?"),
                                                                actions: [
                                                                  TextButton(
                                                                    child: const Text(
                                                                        "Cancel"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: const Text(
                                                                        "Delete"),
                                                                    onPressed:
                                                                        () {
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
