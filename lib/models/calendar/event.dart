import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay start;
  final TimeOfDay end;
  final String description;

  const Event(
    this.title,
    this.start,
    this.end,
    this.description,
  );

  @override
  String toString() => title;
  TimeOfDay toStartTime() => start;
  TimeOfDay toEndTime() => end;
  String toDescription() => description;
}
