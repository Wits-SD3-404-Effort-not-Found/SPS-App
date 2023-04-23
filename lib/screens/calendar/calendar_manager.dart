import 'dart:convert';
//import 'dart:html';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final String serverAddress = '164.92.183.156';
final String serverPort = '80';

int accountID = LoginManager.getAccountID();

class Events {
  Events(
      {required this.event_id,
      this.startDate,
      this.endDate,
      this.eventName,
      this.description,
      this.background});

  int event_id; //need to get account id from the login
  DateTime? startDate;
  DateTime? endDate;
  String? eventName;
  String? description;
  Color? background;
}

class Rotations extends Events {
  Rotations(
      {eventId,
      startDate,
      endDate,
      eventName,
      description,
      background,
      required this.rotation_id,
      this.hospital,
      this.discipline})
      : super(
            event_id: eventId,
            startDate: startDate,
            endDate: endDate,
            eventName: eventName,
            description: description,
            background: background);

  int rotation_id;

  String? hospital;
  String? discipline;
}

List<Rotations> getRotations(List<Events> eventsList) {
  List<Rotations> rotations = [];
  for (var event in eventsList) {
    if (event is Rotations) {
      rotations.add(event);
    }
  }
  return rotations;
}

DateTime convertDateFromString(String date) {
  String newDate = date.substring(0, 19);
  return DateTime.parse(newDate);
}

class EventsDataSource extends CalendarDataSource {
  //Data binding to our eventsList
  EventsDataSource(List<Events> source) {
    appointments = source;
  }

  //All override methods below -> map the properties in the underlying data source to the calendar appointments in CalendarDataSource.
  //i.e getStartTime maps our variable startDate to startTime of Appointment.
  // use this when customising your appointments (i.e events)
  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDate;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getNotes(int index) {
    return appointments![index].description;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

// Future<List<Events>> getEventsData() async {
//   List<Events> eventsList = <Events>[];

//   Events event1 = Events(
//       event_id: 1,
//       startDate: DateTime(2023, 4, 22, 8),
//       endDate: DateTime(2023, 4, 22, 10),
//       eventName: 'Tutorial',
//       description: 'Anatomy',
//       background: const Color(0xFF8B1FA9));
//   Events event2 = Events(
//       event_id: 2,
//       startDate: DateTime(2023, 4, 24),
//       endDate: DateTime(2023, 4, 26),
//       eventName: 'Assignment',
//       description: 'physiology',
//       background: const Color(0xFF8B1FA9));
//   eventsList.add(event1);
//   eventsList.add(event2);

//   Rotations rotation1 = Rotations(
//       eventId: 3,
//       rotation_id: 1,
//       startDate: DateTime(2023, 4, 25),
//       endDate: DateTime(2023, 5, 24),
//       eventName: '',
//       description: '',
//       hospital: 'Barrow Hospital',
//       discipline: 'General Surgery',
//       background: const Color(0xFFF00000));

//   Rotations rotation2 = Rotations(
//       eventId: 5,
//       rotation_id: 2,
//       startDate: DateTime(2023, 6, 25),
//       endDate: DateTime(2023, 7, 24),
//       eventName: '',
//       description: '',
//       hospital: 'Morningside Hospital',
//       discipline: 'Pediatrics',
//       background: const Color(0xFFF00000));

//   eventsList.add(rotation1);
//   eventsList.add(rotation2);
//   return eventsList;
// }