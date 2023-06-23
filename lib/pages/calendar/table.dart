import 'dart:collection';

import 'package:app/data/utils.dart';
import 'package:app/models/calendar/event.dart';
import 'package:app/pages/calendar/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({super.key});

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void deleteEvent(DateTime date) {
    events.remove(date);
  }

  void addEvent(
    DateTime date,
    String title,
    TimeOfDay start,
    TimeOfDay end,
    String description,
  ) {
    setState(() {
      if (events.containsKey(date)) {
        events[date]!.add(Event(title, start, end, description));
      } else {
        events.addAll({
          date: [Event(title, start, end, description)]
        });
      }
    });
  }

  void _showEditEventDialog(
      BuildContext context,
      TextEditingController eventDate,
      TextEditingController eventTitle,
      TextEditingController eventStartTime,
      TextEditingController eventEndTime,
      TextEditingController eventDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: eventDate,
                decoration: InputDecoration(
                  labelText: 'Date time',
                  hintText: 'yyyy-mm-dd',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: today,
                        firstDate: firstDay,
                        lastDate: lastDay,
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            eventDate.text =
                                "${date.year}-${date.month}-${date.day}";
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
              TextField(
                controller: eventTitle,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: eventStartTime,
                decoration: InputDecoration(
                  labelText: 'Start time',
                  hintText: 'hh-mm',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_alarm),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          setState(() {
                            eventStartTime.text = "${time.hour}:${time.minute}";
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
              TextField(
                controller: eventEndTime,
                decoration: InputDecoration(
                  labelText: 'End time',
                  hintText: 'hh:mm',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_alarm),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          setState(() {
                            eventEndTime.text = "${time.hour}:${time.minute}";
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
              TextField(
                controller: eventDescription,
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Complete'),
              onPressed: () {
                deleteEvent(DateFormat('yyyy-MM-dd').parse(eventDate.text));
                addEvent(
                  DateFormat('yyyy-MM-dd').parse(eventDate.text),
                  eventTitle.text,
                  TimeOfDay(
                      hour: int.parse(eventStartTime.text.split(':')[0]),
                      minute: int.parse(eventStartTime.text.split(':')[1])),
                  TimeOfDay(
                      hour: int.parse(eventEndTime.text.split(':')[0]),
                      minute: int.parse(eventEndTime.text.split(':')[1])),
                  eventDescription.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return CalendarHeader(
              focusedDay: value,
              clearButtonVisible: canClearSelection,
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onHeaderTap: () async {
                showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: firstDay,
                  lastDate: lastDay,
                  fieldLabelText: 'Select date',
                  fieldHintText: 'Month/Date/Year',
                  initialEntryMode: DatePickerEntryMode.input,
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      _focusedDay.value = date;
                      _selectedDays.add(date);
                    });
                  }
                });
              },
              onTodayButtonTap: () {
                setState(() => _focusedDay.value = DateTime.now());
              },
              onClearButtonTap: () {
                setState(() {
                  _rangeStart = null;
                  _rangeEnd = null;
                  _selectedDays.clear();
                  _selectedEvents.value = [];
                });
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            );
          },
        ),
        TableCalendar<Event>(
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: _focusedDay.value,
          headerVisible: false,
          selectedDayPredicate: (day) => _selectedDays.contains(day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() => _calendarFormat = format);
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          color: Colors.blue,
        ),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => commingSoon(context),
                      onLongPress: () => _showEditEventDialog(
                        context,
                        TextEditingController(text: value[index].toString()),
                        TextEditingController(text: value[index].title),
                        TextEditingController(
                            text:
                                '${value[index].start.hour.toString()}:${value[index].start.minute.toString()}'),
                        TextEditingController(
                            text:
                                '${value[index].end.hour.toString()}:${value[index].end.minute.toString()}'),
                        TextEditingController(text: value[index].description),
                      ),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void commingSoon(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comming soon'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
