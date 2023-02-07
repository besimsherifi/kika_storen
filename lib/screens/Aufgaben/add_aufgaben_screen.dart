import 'package:flutter/material.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/Aufgaben/aufgab_color.dart';

class AddAufgabenScreen extends StatefulWidget {
  const AddAufgabenScreen({Key? key}) : super(key: key);

  static const routeName = '/Add-aufgaben-screen';

  @override
  State<AddAufgabenScreen> createState() => _AddTerminScreenState();
}

class _AddTerminScreenState extends State<AddAufgabenScreen> {
  final editMode = false;
  var selectedColor = 0;
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(selectedColor);
    return Scaffold(
      appBar: AppBar(
        title: editMode ? const Text("Berbaiten") : const Text('Neuer Termin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // contactInputs('Aufgabe Titel', titleController),
            // terminInputs("Aufgabe Titel", 'hello', titleController, 1, widget),
            // terminInputs(
            //     "Aufgabenbeschreibung", 'hello', titleController, 3, widget),
            TerminColor()
          ],
        ),
      ),
    );
  }
}
