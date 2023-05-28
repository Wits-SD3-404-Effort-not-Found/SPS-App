import 'dart:collection';
import 'dart:ui';

import 'package:sps_app/account_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

int accountID = AccountManager.getID();

class Events {
  Events(
      {required this.eventId,
      required this.startDate,
      required this.endDate,
      this.eventName,
      this.description,
      this.background});

  int eventId;
  DateTime startDate = DateTime(2000);
  DateTime endDate = DateTime(2000);
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
      required this.rotationId,
      this.hospital,
      this.discipline})
      : super(
            eventId: eventId,
            startDate: startDate,
            endDate: endDate,
            eventName: hospital,
            description: discipline,
            background: background);

  int rotationId;

  String? hospital;
  String? discipline;
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
  Color getColor(int index) {
    return appointments![index].background;
  }
}

//Filtering function used in Dropdown in Calendar
Future<List<Events>> getFiltering(String type, List<Events> eventsList) async {
  List<Events> filteredEvents = [];
  for (var event in eventsList) {
    if (event is Rotations && type == "Rotations") {
      filteredEvents.add(event);
    } else if (event is! Rotations && type == "Events") {
      filteredEvents.add(event);
    } else if (type == "All") {
      filteredEvents.add(event);
    }
  }

  return filteredEvents;
}

//Class for everything Modal related
class ModalManager {
  static LinkedHashMap<DateTime, List<Events>> allEvents =
      LinkedHashMap(equals: isSameDay, hashCode: getHashCode);

  //populates the allEvents
  static void allTheEvents(List<Events> events) {
    for (var event in events) {
      final days = daysInRange(event.startDate, event.endDate); //
      for (final d in days) {
        if (allEvents[d] == null) {
          allEvents[d] = [];
        }
        allEvents[d]?.add(event);
      }
    }
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  static List<DateTime> daysInRange(DateTime start, DateTime last) {
    final dayCount = last.difference(start).inDays + 1;

    return List.generate(dayCount,
        (index) => DateTime.utc(start.year, start.month, start.day + index));
  }

  //gets all events for day thats selected
  static List<Events> getEventsForDay(DateTime date) {
    return ModalManager.allEvents[date] ?? [];
  }
}
