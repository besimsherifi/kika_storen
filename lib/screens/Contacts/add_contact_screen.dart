import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';
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
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuer Kontakt'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(10),
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
            contactInputs('Name', controllerName),
            // if (selectedValue != "Intern") contactInputs('Firma'),
            // if (selectedValue == "Lieferant")
            //   contactInputs('Lieferanten-Nummer'),
            // if (selectedValue == "Lieferant")
            //   contactInputs('Unsere Kunden-Nummer'),
            // if (selectedValue == "Kunden") contactInputs('Kunden-Nummer'),
            // contactInputs('Strasse'),
            // contactInputs('PLZ'),
            // contactInputs('Ort'),
            // contactInputs('Telefon'),
            // contactInputs('Mobil'),
            // contactInputs('E-Mail'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    final contact = Contact(controllerName.text);
                    createContact(contact);
                    print(contact);
                    // Navigator.pop(context);
                  },
                  child: const Text('Spiechern'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future createContact(Contact contact) async {
  final docContact = FirebaseFirestore.instance
      .collection('/contacts/xisVa0yhhSlqGwEY67te/Intern/XWP6FkInOW2c15af7ZTX')
      .doc();
  final json = jsonEncode(contact);
  // await docContact.set(json);
}
