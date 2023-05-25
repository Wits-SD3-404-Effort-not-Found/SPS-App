import 'dart:collection';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:sps_app/account_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

// coverage:ignore-start
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
  String newDate = date.substring(0, 16);
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

//Filtering the Rotations (Maybe make class for filtering?)
List<Rotations> getRotations(List<Events> eventsList) {
  List<Rotations> rotations = [];
  for (var event in eventsList) {
    if (event is Rotations) {
      rotations.add(event);
    }
  }
  return rotations;
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

Future<List<Events>> getEventsHardcodedData() async {
  List<Events> eventsList = <Events>[];

  Events event1 = Events(
      eventId: 1,
      startDate: DateTime(2023, 4, 22, 8),
      endDate: DateTime(2023, 4, 22, 10),
      eventName: 'Tutorial',
      description: 'Anatomy',
      background: const Color(0xFF8B1FA9));
  Events event2 = Events(
      eventId: 2,
      startDate: DateTime(2023, 4, 24),
      endDate: DateTime(2023, 4, 26),
      eventName: 'Assignment',
      description: 'physiology',
      background: const Color(0xFF8B1FA9));
  eventsList.add(event1);
  eventsList.add(event2);

  Rotations rotation1 = Rotations(
      eventId: 3,
      rotationId: 1,
      startDate: DateTime(2023, 4, 25),
      endDate: DateTime(2023, 5, 24),
      eventName: '',
      description: '',
      hospital: 'Barrow Hospital',
      discipline: 'General Surgery',
      background: const Color(0xFFF00000));

  Rotations rotation2 = Rotations(
      eventId: 5,
      rotationId: 2,
      startDate: DateTime(2023, 6, 25),
      endDate: DateTime(2023, 7, 24),
      eventName: '',
      description: '',
      hospital: 'Morningside Hospital',
      discipline: 'Pediatrics',
      background: const Color(0xFFF00000));

  eventsList.add(rotation1);
  eventsList.add(rotation2);
  return eventsList;
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
// coverage:ignore-end