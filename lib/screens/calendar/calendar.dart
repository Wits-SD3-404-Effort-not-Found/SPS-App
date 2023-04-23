import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:sps_app/screens/calendar/modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../http_handler.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: CalendarPage());
  }
}

class _CalendarPageState extends State<CalendarPage> {
  final List<Color> _colorCollection = <Color>[];

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    //_initializeEventColor();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: HTTPManager.getAllEventsData(),
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
                    // the modal into view instead of staying on the calendar. This breaks things for some reason.
                    selectionDecoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF043673), width: 2)),
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
                      navigationDirection: MonthNavigationDirection.vertical,
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
                          appointmentTextStyle:
                              TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                          backgroundColor: Color(0xFFFFFFFF)),
                    ),
                    dataSource: EventsDataSource(snapshot.data),
                  ),
                ),
              ));
            } else {
              return Container(
                child: const Center(
                  child: Text('The Calendar is not fucking working'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void selectionChanged(CalendarSelectionDetails details) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: ModalScreen(
          focusDay: details.date!,
        ));
  }

  // Future<List<Meeting>> getDataFromWeb() async {
  //   var data = await http.get(Uri.parse(
  //       "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
  //   var jsonData = json.decode(data.body);

  //   final List<Meeting> appointmentData = [];
  //   final Random random = new Random();
  //   for (var data in jsonData) {
  //     Meeting meetingData = Meeting(
  //         eventName: data['Subject'],
  //         from: _convertDateFromString(
  //           data['StartTime'],
  //         to: _convertDateFromString(data['EndTime']),
  //         background: _colorCollection[random.nextInt(2)],
  //         allDay: data['AllDay']);
  //     appointmentData.add(meetingData);
  //   }
  //   return appointmentData;
  // }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
  }
}
