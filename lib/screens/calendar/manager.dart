import 'dart:collection';

import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:table_calendar/table_calendar.dart';

List<Events> getEventsModalData() {
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
  Events event3 = Events(
      event_id: 2,
      startDate: DateTime(2023, 4, 24, 10),
      endDate: DateTime(2023, 4, 24, 12),
      eventName: 'Tutorial',
      description: 'physiology');
  eventsList.add(event1);
  eventsList.add(event2);
  eventsList.add(event3);
  return eventsList;
}

late LinkedHashMap<DateTime, List<Events>> allEvents =
    LinkedHashMap(equals: isSameDay, hashCode: getHashCode);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

allTheEvents(List<Events> events) {
  events.forEach((event) {
    DateTime date = DateTime.utc(event.startDate!.year, event.startDate!.month,
        event.startDate!.day, 12);
    if (allEvents[date] == null) {
      allEvents[date] = [];
    }
    allEvents[date]?.add(event);
  });
}

List<DateTime> daysInRange(DateTime start, DateTime last) {
  final dayCount = last.difference(start).inDays + 1;

  return List.generate(dayCount,
      (index) => DateTime.utc(start.year, start.month, start.day + index));
}
