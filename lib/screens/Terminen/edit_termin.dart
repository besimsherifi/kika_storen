import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/models/termin.dart';
import 'package:kika_storen/widgets/button.dart';

import '../../services/firestore_service.dart';
import '../../utils/helper_widgets.dart';

class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final Termin event;
  const EditEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      required this.event})
      : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final firestoreService = FirestoreService();
  late DateTime _selectedDate;
  late TextEditingController _titleController;
  late TextEditingController addressController;
  late TextEditingController notesController;
  late TimeOfDay time = TimeOfDay.now();
  var updateTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
    _titleController = TextEditingController(text: widget.event.name);
    addressController = TextEditingController(text: widget.event.address);
    notesController = TextEditingController(text: widget.event.notes);
    updateTime = widget.event.time.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ereignis berbaiten")),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          terminInputs(
            controller: _titleController,
            hint: "Name",
            title: "Name des Eriginis",
            icon: const Icon(
              Icons.abc,
              color: Colors.grey,
            ),
            readOnly: false,
          ),
          terminInputs(
              controller: addressController,
              hint: "Standort",
              title: "Standort",
              icon: const Icon(
                Icons.place,
                color: Colors.grey,
              ),
              readOnly: false),
          terminInputs(
            title: "Datum",
            hint: DateFormat.yMd().format(_selectedDate).toString(),
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
                    _selectedDate = pickDate;
                  });
                }
              },
              child: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          terminInputs(
              title: "Zeit",
              hint: updateTime,
              maxLines: 1,
              readOnly: true,
              icon: GestureDetector(
                onTap: () async {
                  var pickedTimer = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (pickedTimer == null) {
                    return;
                  } else {
                    setState(() {
                      time = pickedTimer;
                      final localizations = MaterialLocalizations.of(context);
                      final formattedTimeOfDay =
                          localizations.formatTimeOfDay(time);
                      updateTime = formattedTimeOfDay;
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
              Icons.notes,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  onTap: () {
                    _addEvent();
                  },
                  label: "Spiechern",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    firestoreService.updateAppointment(
        name: _titleController.text,
        address: addressController.text,
        date: _selectedDate,
        time: updateTime,
        id: widget.event.id,
        notes: notesController.text);
    if (mounted) {
      showToast("Termin erfolgreich bearbeitet");

      Navigator.pop<bool>(context, true);
    }
  }
}
