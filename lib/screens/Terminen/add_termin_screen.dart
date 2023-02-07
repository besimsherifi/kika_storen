import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/button.dart';

import '../../services/firestore_service.dart';

class AddTerminScreen extends StatefulWidget {
  const AddTerminScreen({Key? key}) : super(key: key);

  static const routeName = '/Add-termin-screen';

  @override
  State<AddTerminScreen> createState() => _AddTerminScreenState();
}

class _AddTerminScreenState extends State<AddTerminScreen> {
  final firestoreService = FirestoreService();
  final editMode = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final nameController = TextEditingController();
  final addresController = TextEditingController();
  final dateController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay = localizations.formatTimeOfDay(time);
    return Scaffold(
      appBar: AppBar(
        title: editMode ? const Text("Berbaiten") : const Text('Neuer Termin'),
        actions: [
          GestureDetector(
              onTap: () async {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Column(
          children: [
            terminInputs(
                title: "Name des Ereignis",
                hint: "Name",
                controller: nameController,
                maxLines: 1,
                readOnly: false,
                icon: const Icon(
                  Icons.abc,
                  color: Colors.grey,
                )),
            terminInputs(
                title: "Standort",
                hint: "Standort",
                controller: addresController,
                maxLines: 1,
                readOnly: false,
                icon: const Icon(
                  Icons.place,
                  color: Colors.grey,
                )),
            terminInputs(
                title: "Datum",
                hint: DateFormat.yMd().format(selectedDate).toString(),
                maxLines: 1,
                readOnly: true,
                icon: GestureDetector(
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                          locale: const Locale('de'),
                          context: context,
                          firstDate: DateTime(2022),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2123));
                      if (pickDate != null) {
                        setState(() {
                          selectedDate = pickDate;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ))),
            terminInputs(
                title: "Zeit",
                hint: time.format(context).toString(),
                maxLines: 1,
                readOnly: false,
                icon: GestureDetector(
                  onTap: () async {
                    var pickedTimer = await showTimePicker(
                        context: context, initialTime: time);
                    if (pickedTimer == null) {
                      return;
                    } else {
                      setState(() {
                        time = pickedTimer;
                      });
                    }
                  },
                  child: const Icon(
                    Icons.timer_sharp,
                    color: Colors.grey,
                  ),
                )),
            terminInputs(
                title: "Notizen",
                hint: "Notizen",
                controller: notesController,
                maxLines: 5,
                readOnly: false,
                icon: const Icon(
                  Icons.note,
                  color: Colors.grey,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                      label: "Spiechern",
                      onTap: () {
                        firestoreService.createAppointment(
                            nameController.text,
                            addresController.text,
                            DateFormat.yMd().format(selectedDate).toString(),
                            // selectedDate,
                            formattedTimeOfDay,
                            notesController.text);
                        print(DateFormat.yMd().format(selectedDate).toString());
                        print(selectedDate);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
