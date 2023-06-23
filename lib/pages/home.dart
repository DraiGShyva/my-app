import 'package:app/models/calendar/event.dart';
import 'package:app/models/drawer/list_page.dart';
import 'package:app/pages/calendar/table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app/data/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  void _showAddEventDialog(BuildContext context) {
    TextEditingController eventDate = TextEditingController();
    TextEditingController eventTitle = TextEditingController();
    TextEditingController eventStartTime = TextEditingController();
    TextEditingController eventEndTime = TextEditingController();
    TextEditingController eventDescription = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
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
              child: const Text('Add'),
              onPressed: () {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calendar'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Sort by time'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Sort by name'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Sort by location'),
                ),
              ];
            },
            onSelected: (int value) {
              switch (value) {
                case 1:
                  commingSoon(context);
                  break;
                case 2:
                  commingSoon(context);
                  break;
                case 3:
                  commingSoon(context);
                  break;
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const Icon(
              Icons.account_box_outlined,
              size: 150,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: const ListPageDrawer(),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const CalendarTable(),
          Container(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
            alignment: Alignment.bottomRight,
            child: Ink(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  _showAddEventDialog(context);
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(10.0),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
