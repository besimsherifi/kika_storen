import 'package:flutter/material.dart';

import '../../utils/helper_widgets.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  static const routeName = '/Add-contact-screen';

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Intern", child: Text("Intern")),
      const DropdownMenuItem(value: "Extern", child: Text("Extern")),
      const DropdownMenuItem(value: "Lieferant", child: Text("Lieferant")),
      const DropdownMenuItem(value: "Kunden", child: Text("Kunden")),
    ];
    return menuItems;
  }

  String selectedValue = 'Intern';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(60),
            DropdownButton(
              value: selectedValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: dropdownItems,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
            contactInputs('Name'),
            if (selectedValue != "Intern") contactInputs('Firma'),
            if (selectedValue == "Lieferant")
              contactInputs('Lieferanten-Nummer'),
            if (selectedValue == "Lieferant")
              contactInputs('Unsere Kunden-Nummer'),
            if (selectedValue == "Kunden") contactInputs('Kunden-Nummer'),
            contactInputs('Strasse'),
            contactInputs('PLZ'),
            contactInputs('Ort'),
            contactInputs('Telefon'),
            contactInputs('Mobil'),
            contactInputs('E-Mail'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Spiechern'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Abbrechen'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
