import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final String serverAddress = '164.92.183.156';
final String serverPort = '80';

class Events {
  Events(
      {required this.event_id,
      this.startDate,
      this.endDate,
      this.eventName,
      this.description});

  int event_id;
  int account_id =
      LoginManager.getAccountID(); //need to get account id from the login
  DateTime? startDate;
  DateTime? endDate;
  String? eventName;
  String? description;
}

// Future<List<Events>> getEventsData() async {
//   //might need to fix up especially with account_id as we need to send that data
//   var data =
//       await http.get(Uri.parse('http://$serverAddress:$serverPort/events/'));

//   var jsonData = json.decode(data.body);

//   final List<Events> eventsList = [];

//   for (var data in jsonData) {
//     Events eventData = Events(
//         event_id: data['event_id'],
//         account_id:
//             LoginManager.getAccountID(), // check this actually gets the ID
//         start_date: _convertDateFromString(data['start_date']),
//         end_date: _convertDateFromString(data['end_date']),
//         name: data['name'],
//         description: data['description']);
//     eventsList.add(eventData);
//   }
//   return eventsList;
// }

Future<List<Events>> getEventsData() async {
  List<Events> eventsList = <Events>[];

  Events event1 = Events(
      event_id: 1,
      startDate: DateTime(2023, 4, 22, 8),
      endDate: DateTime(2023, 4, 22, 10),
      eventName: 'Tutorial',
      description: 'Anatomy');
  Events event2 = Events(
      event_id: 2,
      startDate: DateTime(2023, 4, 24),
      endDate: DateTime(2023, 4, 26),
      eventName: 'Assignment',
      description: 'physiology');
  eventsList.add(event1);
  eventsList.add(event2);
  return eventsList;
}

DateTime _convertDateFromString(String date) {
  return DateTime.parse(date);
}

class EventsDataSource extends CalendarDataSource {
  //Data binding to our eventsList
  EventsDataSource(List<Events> source) {
    appointments = source;
  }

  // @override
  // int getEvent_id(int index) {
  //   return appointments![index].event_id;
  // }

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
}
