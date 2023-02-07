import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/screens/Terminen/terminen_list_scren.dart';
import 'package:kika_storen/services/firestore_service.dart';
import 'package:kika_storen/utils/constants.dart';
import 'package:kika_storen/widgets/button.dart';
import 'package:table_calendar/table_calendar.dart';

class TerminenScreen extends StatefulWidget {
  TerminenScreen({Key? key}) : super(key: key);

  static const routeName = '/Termine-screen';

  @override
  State<TerminenScreen> createState() => _TerminenScreenState();
}

class _TerminenScreenState extends State<TerminenScreen> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          addTerminBar(context),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: kKikaBlueColor,
              locale: 'de',
              monthTextStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
              dateTextStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
              dayTextStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
              onDateChange: (date) {
                selectedDate = date;
                setState(() {});
              },
            ),
          ),
          TerminenListScreen(
            date: DateFormat.yMd().format(selectedDate).toString(),
          )
        ],
      ),

      //     TableCalendar(
      //   firstDay: DateTime.utc(2010, 10, 20),
      //   lastDay: DateTime.utc(2040, 10, 20),
      //   focusedDay: _focusedDay,
      //   calendarFormat: _calendarFormat,
      //   selectedDayPredicate: (day) {
      //     // Use `selectedDayPredicate` to determine which day is currently selected.
      //     // If this returns true, then `day` will be marked as selected.
      //     // Using `isSameDay` is recommended to disregard
      //     // the time-part of compared DateTime objects.
      //     return isSameDay(_selectedDay, day);
      //   },
      //   onDaySelected: (selectedDay, focusedDay) {
      //     if (!isSameDay(_selectedDay, selectedDay)) {
      //       // Call `setState()` when updating the selected day
      //       setState(() {
      //         _selectedDay = selectedDay;
      //         _focusedDay = focusedDay;
      //       });
      //       print(selectedDay);
      //     }
      //   },
      //   onFormatChanged: (format) {
      //     if (_calendarFormat != format) {
      //       // Call `setState()` when updating calendar format
      //       setState(() {
      //         _calendarFormat = format;
      //       });
      //     }
      //   },
      //   onPageChanged: (focusedDay) {
      //     // No need to call `setState()` here
      //     _focusedDay = focusedDay;
      //   },
      // ),
    );
  }
}

appBar() {
  return AppBar(
    title: const Text('Terminen'),
    actions: [Icon(Icons.calendar_today)],
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
