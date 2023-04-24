import 'dart:collection';

import 'package:sps_app/screens/calendar/calendar_manager.dart';
import 'package:table_calendar/table_calendar.dart';

LinkedHashMap<DateTime, List<Events>> allEvents =
    LinkedHashMap(equals: isSameDay, hashCode: getHashCode);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

void allTheEvents(List<Events> events) {
  for (var event in events) {
    final days =
        daysInRange(event.startDate as DateTime, event.endDate as DateTime); //
    for (final d in days) {
      if (allEvents[d] == null) {
        allEvents[d] = [];
      }
      allEvents[d]?.add(event);
    }
  }
}

List<DateTime> daysInRange(DateTime start, DateTime last) {
  final dayCount = last.difference(start).inDays + 1;

  return List.generate(dayCount,
      (index) => DateTime.utc(start.year, start.month, start.day + index));
}
