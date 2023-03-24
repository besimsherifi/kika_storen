import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/models/project.dart';
import 'package:kika_storen/screens/Projekten/project_detail_screen.dart';
import 'package:kika_storen/screens/Projekten/projekt_item.dart';
import 'package:table_calendar/table_calendar.dart';

class ArbeitsplanungScreen extends StatefulWidget {
  const ArbeitsplanungScreen({Key? key}) : super(key: key);

  static const routeName = '/Arbeitsplanung-screen';

  @override
  State<ArbeitsplanungScreen> createState() => _ArbeitsplanungScreenState();
}

class _ArbeitsplanungScreenState extends State<ArbeitsplanungScreen> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<Project>> _termine;
  late Stream<QuerySnapshot> _firestoreEventsStream;
  // late DateTime _firstDay;
  // late DateTime _lastDay;

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
        .collection('projects')
        .withConverter(
          fromFirestore: Project.fromFirestore,
          toFirestore: (Project project, options) => project.toFirestore(),
        )
        .snapshots();

    _firestoreEventsStream.listen((QuerySnapshot snap) {
      _termine.clear();
      for (var doc in snap.docs) {
        final Project project = doc.data() as Project;
        final day = DateTime.utc(project.startDate.year,
            project.startDate.month, project.startDate.day);
        if (_termine[day] == null) {
          _termine[day] = [];
        }
        _termine[day]!.add(project);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arbeitsplanung"),
      ),
      body: Column(
        children: [
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
                      (event) => ProjektItem(
                          event: event,
                          onTap: () async {
                            final res = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProjectDetailScreen(
                                  project: event,
                                ),
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
                                    "Sind Sie sicher, dass Sie löschen möchten?"),
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
                                  .collection('projects')
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
