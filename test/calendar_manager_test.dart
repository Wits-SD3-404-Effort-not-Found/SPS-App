import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';

void main() {
  //create mock for events, rotations
  Events event1 = Events(
      eventId: 1,
      startDate: DateTime(2023, 4, 22, 8),
      endDate: DateTime(2023, 4, 22, 10),
      eventName: 'Tutorial',
      description: 'Anatomy',
      background: const Color(0xFF8B1FA9));

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

  List<Events> eventsList = [event1, rotation1];

  //testing Filtering using above mock data
  group('Filtering', () {
    test("test for filtering events", () async {
      String type = "Events";
      List<Events> events = [event1];
      await expectLater(getFiltering(type, eventsList), completion(events));
    });

    test("test for filtering rotations", () async {
      String type = "Rotations";
      List<Events> rotations = [rotation1];
      await expectLater(getFiltering(type, eventsList), completion(rotations));
    });

    test("test for filtering all", () async {
      String type = "All";
      List<Events> all = [event1, rotation1];
      await expectLater(getFiltering(type, eventsList), completion(all));
    });
  });

  test("test convert date from string", () {
    String stringdate = "2022-01-07 00:00:00 UTC";

    DateTime actualdate = DateTime(2022, 1, 7, 0, 0);

    expect(convertDateFromString(stringdate), actualdate);
  });

  group('Modal', () {
    List<Events> event = [
      Events(
          eventId: 1,
          startDate: DateTime(2023, 4, 22, 8),
          endDate: DateTime(2023, 4, 22, 10),
          eventName: 'Tutorial',
          description: 'Anatomy',
          background: const Color(0xFF8B1FA9))
    ];

    test('test allTheEvents populates', () {
      ModalManager.allTheEvents(event);
    });

    test('test getHashCode', () {
      DateTime date = DateTime(2023, 4, 1);
      int hashcode = 1042023;
      expect(ModalManager.getHashCode(date), hashcode);
    });

    test('test getEventsForDay gets the events for a specific day', () {
      DateTime date = DateTime(2023, 4, 22);

      expect(ModalManager.getEventsForDay(date), event);
    });
    test('test getEventsForDay when there are no events', () {
      DateTime date = DateTime(2013, 8, 1);
      expect(ModalManager.getEventsForDay(date), isEmpty);
    });

    test('test daysInrAnge returns all days in a specific range', () {
      DateTime startDate = DateTime(2023, 4, 5);
      DateTime endDate = DateTime(2023, 4, 8);

      List range = [
        DateTime.utc(2023, 4, 5),
        DateTime.utc(2023, 4, 6),
        DateTime.utc(2023, 4, 7),
        DateTime.utc(2023, 4, 8)
      ];
      expect(ModalManager.daysInRange(startDate, endDate), range);
    });
  });
}
