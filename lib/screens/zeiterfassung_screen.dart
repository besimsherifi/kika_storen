import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/constants.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/button.dart';
import 'package:provider/provider.dart';

import '../models/report.dart';
import '../providers/timer_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ZeiterfassungScreen extends StatefulWidget {
  const ZeiterfassungScreen({Key? key}) : super(key: key);

  static const routeName = '/Zeiterfassung-screen';

  @override
  State<ZeiterfassungScreen> createState() => _ZeiterfassungScreenState();
}

class _ZeiterfassungScreenState extends State<ZeiterfassungScreen> {
  DateTime? clockInTime;
  DateTime? breakStartTime;

  void clockIn() {
    clockInTime = DateTime.now();
    print(clockInTime);
  }

  void startBreak() {
    breakStartTime = DateTime.now();
  }

  String? getClockInTime() {
    if (clockInTime == null) {
      return null;
    }

    final timeDifference = DateTime.now().difference(clockInTime!);
    int diff = timeDifference.inMinutes;
    return formatDuration(timeDifference);
  }

  String? getTimeSinceBreakStarted() {
    if (breakStartTime == null) {
      return null;
    }

    final timeDifference = DateTime.now().difference(breakStartTime!);
    int diff = timeDifference.inMinutes;
    print(diff);
    return formatDuration(timeDifference);
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours hour${hours == 1 ? '' : 's'} ${minutes}min';
    }
    return '$minutes min';
  }

  var timer;
  int selectedMonth = 0;
  int currentMonth = 0;
  int monthlyHours = 0;
  int monthlyMinutes = 0;
  var email = '';
  DateTime selectedDate = DateTime.now();
  late Stream<QuerySnapshot> _firestoreEventsStream;
  final List<String> monthNames = [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember'
  ];

  getCurrentUserEmail() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String email = user?.email ?? '';
    this.email = email;
  }

  _loadFirestoreEvents(month) async {
    _firestoreEventsStream = FirebaseFirestore.instance
        .collection('hours')
        .doc(email)
        .collection(month.toString())
        .withConverter(
          fromFirestore: Report.fromFirestore,
          toFirestore: (Report project, options) => project.toFirestore(),
        )
        .snapshots();

    _firestoreEventsStream.listen((QuerySnapshot snap) {
      monthlyHours = 0;
      for (var doc in snap.docs) {
        final Report report = doc.data() as Report;
        monthlyHours += report.hours;
        monthlyMinutes += report.minutes;
        while (monthlyMinutes >= 60) {
          print(monthlyMinutes);
          monthlyHours++;
          monthlyMinutes -= 60;
        }
        // print(report);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Provider.of<TimerProvider>(context, listen: false);
    monthlyHours = 0;
    monthlyMinutes = 0;
    getCurrentUserEmail();
    DateTime now = DateTime.now();
    selectedMonth = now.month;
    _loadFirestoreEvents(selectedMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeiterfassung'),
      ),
      body: homeScreenBody(),
    );
  }

  Widget homeScreenBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          addVerticalSpace(25),
          Center(
            child: Text(
              '${timer.hour}:' '${timer.minute}:' + '${timer.seconds}',
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          addVerticalSpace(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (timer.startEnable)
                  ? ElevatedButton(
                      onPressed: timer.startTimer,
                      // onPressed: clockIn,
                      child: Text('Start'),
                    )
                  : const ElevatedButton(
                      onPressed: null,
                      child: Text('Start'),
                    ),
              (timer.stopEnable)
                  ? ElevatedButton(
                      onPressed: startBreak,
                      child: const Text('Stop'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // print(timer.seconds);
                      },
                      child: const Text('Stop'),
                    ),
              (timer.continueEnable)
                  ? ElevatedButton(
                      onPressed: timer.continueTimer,
                      child: const Text('Continue'),
                    )
                  : const ElevatedButton(
                      onPressed: null,
                      child: Text('Continue'),
                    ),
            ],
          ),
          addVerticalSpace(40),
          CheckboxListTile(
            title: Text("Automaticher Start und Stop"), //    <-- label
            value: false,
            onChanged: (newValue) {},
          ),
          CheckboxListTile(
            title:
                Text("Benachrichtigen Sie mich nach 8 Stunden"), //    <-- label
            value: false,
            onChanged: (newValue) {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Icon(Icons.arrow_left),
                  onTap: () {
                    if (selectedMonth > 0) {
                      selectedMonth -= 1;
                    }
                    monthlyHours = 0;
                    _loadFirestoreEvents(selectedMonth);
                    setState(() {});

                    // print(selectedMonth);
                  },
                ),
                Column(
                  children: [
                    Container(
                      color: kKikaBlueColor,
                      // height: 10,
                      width: 250,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            '$monthlyHours.$monthlyMinutes st',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22),
                          ),
                          Text(monthNames[selectedMonth - 1],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14))
                        ],
                      ),
                    ),
                    Container(
                      color: kKikaBrownColor,
                      height: 10,
                      width: 250,
                    )
                  ],
                ),
                GestureDetector(
                  child: const Icon(Icons.arrow_right),
                  onTap: () {
                    monthlyHours = 0;
                    selectedMonth += 1;
                    _loadFirestoreEvents(selectedMonth);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          // OutlinedButton(
          //     onPressed: () {
          //       // print(monthlyHours);
          //       monthlyHours = 0;
          //       monthlyMinutes = 0;
          //       FirebaseFirestore.instance
          //           .collection('hours')
          //           .doc(email)
          //           .collection(selectedMonth.toString())
          //           .doc()
          //           .set({
          //         'hours': 1,
          //         'minutes': 30,
          //         "date": Timestamp.fromDate(selectedDate),
          //       });
          //     },
          //     child: Text('Save'))
        ],
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ZeiterfassungScreen extends StatefulWidget {
//   static const routeName = '/Zeiterfassung-screen';

//   const ZeiterfassungScreen({Key? key}) : super(key: key);
//   @override
//   _ZeiterfassungScreenState createState() => _ZeiterfassungScreenState();
// }

// class _ZeiterfassungScreenState extends State<ZeiterfassungScreen> {
//   late DateTime _clockInTime;
//   DateTime? _breakTime;
//   int _hours = 0;
//   int _minutes = 0;
//   bool _isClockIn = false;

//   void _handleClockIn() {
//     setState(() {
//       _isClockIn = true;
//       _clockInTime = DateTime.now();
//     });
//   }

//   void _handleTakeBreak() {
//     if (_isClockIn) {
//       setState(() {
//         _breakTime = DateTime.now();
//         Duration duration = _breakTime!.difference(_clockInTime);
//         _hours = duration.inHours;
//         _minutes = duration.inMinutes % 60;
//         _isClockIn = false;
//       });
//     }
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat.jm().format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Tracker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_isClockIn)
//               Text(
//                 'Clocked in at ${_formatDateTime(_clockInTime)}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             if (!_isClockIn && _breakTime != null)
//               Text(
//                 'Break taken at ${_formatDateTime(_breakTime!)}\nTotal time worked: $_hours hours $_minutes minutes',
//                 style: TextStyle(fontSize: 20),
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isClockIn ? null : _handleClockIn,
//               child: Text('Clock In'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isClockIn ? _handleTakeBreak : null,
//               child: Text('Take Break'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
