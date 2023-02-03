import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/constants.dart';
import 'package:kika_storen/widgets/button.dart';

class TerminenScreen extends StatelessWidget {
  TerminenScreen({Key? key}) : super(key: key);

  static const routeName = '/Termine-screen';
  DateTime selectedDate = DateTime.now();

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
              },
            ),
          )
        ],
      ),
    );
  }
}

testing() {}

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

addDateBar() {}
