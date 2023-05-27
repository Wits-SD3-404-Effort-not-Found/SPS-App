import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPopupController extends ChangeNotifier {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  TimeOfDay get startTime => _startTime;

  set startTime(TimeOfDay value) {
    _startTime = value;
    notifyListeners();
  }

  TimeOfDay get endTime => _endTime;

  set endTime(TimeOfDay value) {
    _endTime = value;
    notifyListeners();
  }

  TextEditingController get nameController => _nameController;

  set nameController(TextEditingController value) {
    _nameController = value;
    notifyListeners();
  }

  TextEditingController get descriptionController => _descriptionController;

  set descriptionController(TextEditingController value) {
    _descriptionController = value;
    notifyListeners();
  }
}

class EventsPopup extends StatefulWidget {
  EventsPopup(this.title, this.controller, this.confirmOnPress, {super.key});

  EventPopupController controller;
  String title;
  final VoidCallback confirmOnPress;

  @override
  State<EventsPopup> createState() => _EventsPopupState();
}

class _EventsPopupState extends State<EventsPopup> {
  void selectionChanged(
      DateRangePickerSelectionChangedArgs selectionChangedArgs) {
    widget.controller.startDate = selectionChangedArgs.value.startDate;
    widget.controller.endDate = selectionChangedArgs.value.endDate;
  }

  void _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      widget.controller.startTime = newTime;
    } else {
      widget.controller.startTime = TimeOfDay.now();
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (newTime != null) {
      widget.controller.endTime = newTime;
    } else {
      widget.controller.endTime = TimeOfDay.now();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        widget.title,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: [
        Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // constrained box to encapsulate user input text box
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(275, 50)),
                  child: TextFormField(
                      // styles user input text box
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5)),
                        hintText: 'Event Name',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      // to retrieve the user input text from the TextFormField
                      controller: widget.controller.nameController))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // constrained box to encapsulate user input text box
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(275, 50)),
                  child: TextFormField(
                      // styles user input text box
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5)),
                        hintText: 'Event Description',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      // to retrieve the user input text from the TextFormField
                      controller: widget.controller.descriptionController))),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 30, right: 30, bottom: 8),
                  child: Text(
                    "Select start and end dates:",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onBackground),
                  ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SizedBox(
                height: 300,
                width: 275,
                child: SfDateRangePicker(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  initialDisplayDate: widget.controller.startDate,
                  initialSelectedRange: PickerDateRange(
                      widget.controller.startDate, widget.controller.startDate),
                  startRangeSelectionColor:
                      Theme.of(context).colorScheme.tertiary,
                  endRangeSelectionColor:
                      Theme.of(context).colorScheme.tertiary,
                  rangeSelectionColor: Theme.of(context).colorScheme.tertiary,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: selectionChanged,
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Start time:',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground)),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        fixedSize: const Size(100, 3)),
                    onPressed: _selectStartTime,
                    child: Text(
                      widget.controller.startTime.format(context),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 14),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('End time:',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground)),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        fixedSize: const Size(100, 3)),
                    onPressed: _selectEndTime,
                    child: Text(
                      widget.controller.endTime.format(context),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 14),
                    ),
                  ),
                ],
              ))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              onPressed: widget.confirmOnPress,
              child: Text("Confirm",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary))),
        ])
      ],
    );
  }
}
