import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:sps_app/screens/calendar/modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import '../../http_handler.dart';

Future<List<Events>> eventsList =
    HTTPManager.getAllEventsData(AccountManager.getID());

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String dropdownValue = "All";
  Future<List<Events>> events = eventsList;
  static List<Events> filtered = [];

  double? width, cellWidthHeader, cellWidthDrop;
  String _month = DateTime.now().month.toString();
  String _year = DateTime.now().year.toString();
  final CalendarController _controller = CalendarController();
  @override
  void initState() {
    //_initializeEventColor();
    _getEventsDataSource(
        events); //makes sure that all data shows in the calendar when app first runs
    super.initState();
  }

  void convertFutureToList(Future<List<Events>> events) async {
    List<Events> futureList = await events;
    filtered = List<Events>.from(futureList);
  }

  EventsDataSource _getEventsDataSource(Future<List<Events>> events) {
    convertFutureToList(events);
    return EventsDataSource(filtered);
  }

  //This method allows for the heading that displays the month and year to change when scrolling
  // Need to use this as the header is customised
  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      setState(() {
        _month = DateFormat('MMMM')
            .format(viewChangedDetails
                .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
            .toString();
        _year = DateFormat('yyyy')
            .format(viewChangedDetails
                .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
            .toString();
      });
    });
  }

//coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    cellWidthHeader = width! / 2;
    cellWidthDrop = width! / 4;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: eventsList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                  child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        color: Theme.of(context).colorScheme.background,
                        //width: width,
                        height: 60,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: cellWidthHeader,
                              height: 40,
                              child: Text('$_month $_year',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                            ),
                            Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: DropdownButton(
                                  value: dropdownValue,
                                  dropdownColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  focusColor:
                                      Theme.of(context).colorScheme.secondary,
                                  underline: Container(
                                    height: 2,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  items: <String>["All", "Events", "Rotations"]
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      events = getFiltering(
                                          dropdownValue,
                                          snapshot
                                              .data); //filters the data depending on what filter is chosen
                                      _getEventsDataSource(
                                          events); //updates what data is in the calendar after the filter
                                    });
                                  },
                                ))
                          ],
                        ))),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Center(
                    child: SfCalendar(
                      headerHeight: 0,
                      viewHeaderHeight: 30,
                      viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        dayTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),

                      controller: _controller,
                      dataSource: _getEventsDataSource(events),
                      view: CalendarView.month,
                      onViewChanged: viewChanged,
                      onSelectionChanged: selectionChanged,
                      //initialSelectedDate: Problem Child -> causes things to break because the update moves
                      // the modal into view instead of staying on the calendar. This breaks things for some reason.
                      selectionDecoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2)),
                      cellBorderColor: Theme.of(context).colorScheme.background,
                      backgroundColor: Theme.of(context).colorScheme.background,

                      todayHighlightColor:
                          Theme.of(context).colorScheme.primary,
                      monthViewSettings: MonthViewSettings(
                        navigationDirection: MonthNavigationDirection.vertical,
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        showTrailingAndLeadingDates: false,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                        showAgenda: false,
                        // agendaItemHeight: 60,
                        // agendaStyle: AgendaStyle(
                        //     appointmentTextStyle: TextStyle(
                        //         fontSize: 15,
                        //         color: Theme.of(context).colorScheme.surface),
                        //     backgroundColor:
                        //         Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ),
                ))
              ]));
            } else {
              return const Center(
                child: Text('loading...'),
              );
            }
          },
        ),
      ),
    );
    //coverage:ignore-end
  }

  //allows us to get selected day and pass to table calendar for the focus day
  void selectionChanged(CalendarSelectionDetails details) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: ModalScreen(
          //pass data in here
          focusDay: details.date!,
          //pass filtered data in here.
          data: events,
        ));
  }
}
