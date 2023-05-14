import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:sps_app/screens/calendar/modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../http_handler.dart';

final Future<List<Events>> eventsList =
    HTTPManager.getAllEventsData(AccountManager.getID());

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    //_initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future:
              eventsList, //HTTPManager.getAllEventsData(AccountManager.getID()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: SfCalendar(
                        view: CalendarView.month,
                        onSelectionChanged: selectionChanged,
                        //initialSelectedDate: Problem Child -> causes things to break because the update moves
                        //the modal into view instead of staying on the calendar. This breaks things for some reason.
                        selectionDecoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF043673), width: 2)),
                        cellBorderColor: const Color(0xFFFFFFFF),
                        backgroundColor: const Color(0xFFFFFFFF),
                        headerHeight: 60,
                        headerStyle: const CalendarHeaderStyle(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black),
                            backgroundColor: Color(0xFFFFFFFF)),
                        todayHighlightColor: const Color(0xFF043673),
                        monthViewSettings: const MonthViewSettings(
                          navigationDirection:
                              MonthNavigationDirection.vertical,
                          monthCellStyle: MonthCellStyle(
                            textStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          showTrailingAndLeadingDates: false,
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator,
                          showAgenda: false,
                          agendaItemHeight: 60,
                          agendaStyle: AgendaStyle(
                              appointmentTextStyle: TextStyle(
                                  fontSize: 15, color: Color(0xFFFFFFFF)),
                              backgroundColor: Color(0xFFFFFFFF)),
                        ),
                        dataSource: EventsDataSource(snapshot.data),
                      ),
                    )),
              );
            } else {
              return const Center(
                child: Text('loading...'),
              );
            }
          },
        ),
      ),
    );
  }

  //allows us to get selected day and pass to table calendar for the focus day
  void selectionChanged(CalendarSelectionDetails details) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: ModalScreen(
          //pass data in here
          focusDay: details.date!,
          //pass http data in here.
          data: eventsList,
        ));
  }
}
