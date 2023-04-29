import 'dart:ui';

import 'package:sps_app/account_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

int accountID = AccountManager.getID();

class Events {
  Events(
      {required this.eventId,
      this.startDate,
      this.endDate,
      this.eventName,
      this.description,
      this.background});

  int eventId; //need to get account id from the login
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
  Color getColor(int index) {
    return appointments![index].background;
  }
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
