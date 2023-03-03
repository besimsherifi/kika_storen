import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/models/termin.dart';
import 'package:kika_storen/widgets/button.dart';
import 'package:table_calendar/table_calendar.dart';

import 'edit_termin.dart';
import 'termin_item.dart';

class TerminenScreen extends StatefulWidget {
  const TerminenScreen({Key? key}) : super(key: key);

  static const routeName = '/Termine-screen';

  @override
  State<TerminenScreen> createState() => _TerminenScreenState();
}

class _TerminenScreenState extends State<TerminenScreen> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<Termin>> _termine;
  late Stream<QuerySnapshot> _firestoreEventsStream;

  @override
  void initState() {
    super.initState();
    _termine = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _loadFirestoreEvents();
    setState(() {});
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List _getEventsForTheDay(DateTime day) {
    return _termine[day] ?? [];
  }

  _loadFirestoreEvents() async {
    _firestoreEventsStream = FirebaseFirestore.instance
        .collection('appointments')
        .withConverter(
          fromFirestore: Termin.fromFirestore,
          toFirestore: (Termin termin, options) => termin.toFirestore(),
        )
        .snapshots();

    _firestoreEventsStream.listen((QuerySnapshot snap) {
      _termine.clear();
      for (var doc in snap.docs) {
        final Termin termin = doc.data() as Termin;
        final day =
            DateTime.utc(termin.date.year, termin.date.month, termin.date.day);
        if (_termine[day] == null) {
          _termine[day] = [];
        }
        _termine[day]!.add(termin);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          addTerminBar(context),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: DatePicker(
          //     DateTime.now(),
          //     height: 100,
          //     width: 80,
          //     locale: 'de',
          //     initialSelectedDate: DateTime.now(),
          //     selectionColor: kKikaBlueColor,
          //     dayTextStyle: const TextStyle(color: Colors.grey),
          //     monthTextStyle: const TextStyle(color: Colors.grey),
          //     dateTextStyle: const TextStyle(color: Colors.grey, fontSize: 24),
          //     onDateChange: (date) {
          //       // print(date);
          //       var stringDate = date.toString();
          //       DateTime dateTime = DateTime.parse(stringDate).toUtc();
          //       _getEventsForTheDay(dateTime);
          //       // print(dateTime);
          //     },
          //   ),
          // ),
          TableCalendar(
            locale: 'de',
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForTheDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  // print(selectedDay);
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView(
                children: _getEventsForTheDay(_focusedDay)
                    .map(
                      (event) => EventItem(
                          event: event,
                          onTap: () async {
                            final res = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditEvent(
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now(),
                                    event: event),
                              ),
                            );
                            if (res ?? false) {
                              _loadFirestoreEvents();
                            }
                          },
                          onDelete: () async {
                            final delete = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Termin Löschen ?"),
                                content: const Text(
                                    "Sind Sie sicher, dass Sie löschen möchten ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    child: const Text("Nein"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text("Ja"),
                                  ),
                                ],
                              ),
                            );
                            if (delete ?? false) {
                              await FirebaseFirestore.instance
                                  .collection('appointments')
                                  .doc(event.id)
                                  .delete();
                              _loadFirestoreEvents();
                            }
                          }),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

appBar() {
  return AppBar(
    title: const Text('Terminen'),
  );
}

addTerminBar(context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const Text(
              'Heute',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Button(
            label: "+ Neues Ereignis",
            onTap: () {
              Navigator.of(context).pushNamed('/Add-termin-screen');
            })
      ],
    ),
  );
}
