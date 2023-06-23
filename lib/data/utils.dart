import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/calendar/event.dart';

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final events = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_eventExample);

final _eventExample = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(firstDay.year, firstDay.month, item * 5): List.generate(
        item % 4 + 1,
        (index) => Event('Event $item | ${index + 1}', TimeOfDay.now(),
            TimeOfDay.now(), 'Blank'))
}..addAll({
    today: [
      Event('Today\'s Event 1', TimeOfDay.now(), TimeOfDay.now(), 'Blank'),
      Event('Today\'s Event 2', TimeOfDay.now(), TimeOfDay.now(), 'Blank'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final today = DateTime.now();
final firstDay = DateTime(today.year, today.month - 3, today.day);
final lastDay = DateTime(today.year, today.month + 3, today.day);
