import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

final String serverAddress = '164.92.183.156';
final String serverPort = '80';

class Events {
  Events(
      {this.event_id,
      this.account_id,
      this.start_date,
      this.end_date,
      this.name,
      this.description});

  int? event_id;
  int? account_id; //need to get account id from the login
  DateTime? start_date;
  DateTime? end_date;
  String? name;
  String? description;
}

Future<List<Events>> getEventsData() async {
  //might need to fix up especially with account_id as we need to send that data
  var data =
      await http.get(Uri.parse('http://$serverAddress:$serverPort/events/'));

  var jsonData = json.decode(data.body);

  final List<Events> eventsList = [];

  for (var data in jsonData) {
    Events eventData = Events(
        event_id: data['event_id'],
        account_id: data['account_id'], //will need to change
        start_date: _convertDateFromString(data['start_date']),
        end_date: _convertDateFromString(data['end_date']),
        name: data['name'],
        description: data['description']);
    eventsList.add(eventData);
  }
  return eventsList;
}

DateTime _convertDateFromString(String date) {
  return DateTime.parse(date);
}

class EventsDataSource extends CalendarDataSource {
  //will probably need if statements to see if its general event or rotation
  //need to figure it out
  EventsDataSource(List<Events> source) {
    appointments = source;
  }

  @override
  int getEvent_id(int index) {
    return appointments![index].event_id;
  }

  @override
  int getAccount_id(int index) {
    return appointments![index].account_id;
  }

  @override
  DateTime getStartDate(int index) {
    return appointments![index].start_date;
  }

  @override
  DateTime getEndDate(int index) {
    return appointments![index].end_date;
  }

  @override
  String getName(int index) {
    return appointments![index].name;
  }

  @override
  String getDescription(int index) {
    return appointments![index].description;
  }
}
