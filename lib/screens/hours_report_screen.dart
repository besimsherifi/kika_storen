import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/report.dart';

class HoursReportScreen extends StatefulWidget {
  const HoursReportScreen({Key? key}) : super(key: key);

  @override
  State<HoursReportScreen> createState() => _HoursReportScreenState();
}

class _HoursReportScreenState extends State<HoursReportScreen> {
  @override
  String email = '';
  int currentMonth = 0;
  DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<Report>> _termine;
  late Stream<QuerySnapshot> _firestoreEventsStream;

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail();
    _termine = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _loadFirestoreEvents();
    setState(() {});
    DateTime now = DateTime.now();
    currentMonth = now.month;
  }

  getCurrentUserEmail() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String email = user?.email ?? '';
    this.email = email;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List _getEventsForTheDay(DateTime day) {
    return _termine[day] ?? [];
  }

  _loadFirestoreEvents() async {
    _firestoreEventsStream = FirebaseFirestore.instance
        .collection('hours')
        .doc(email)
        .collection('stunden')
        .withConverter(
          fromFirestore: Report.fromFirestore,
          toFirestore: (Report project, options) => project.toFirestore(),
        )
        .snapshots();

    _firestoreEventsStream.listen((QuerySnapshot snap) {
      _termine.clear();

      for (var doc in snap.docs) {
        final Report report = doc.data() as Report;
        final day =
            DateTime.utc(report.date.year, report.date.month, report.date.day);
        if (_termine[day] == null) {
          _termine[day] = [];
        }
        _termine[day]!.add(report);
        // print(currentMonth);
        print(_termine);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raport'),
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
        ],
      ),
    );
  }
}
