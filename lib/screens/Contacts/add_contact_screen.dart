import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contact_provider.dart';
import '../../services/firestore_service.dart';
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
      const DropdownMenuItem(value: "Lieferanten", child: Text("Lieferanten")),
      const DropdownMenuItem(value: "Kunden", child: Text("Kunden")),
    ];
    return menuItems;
  }

  String category = 'Intern';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  final firestoreService = FirestoreService();
  var edit = false;

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    final nameController = TextEditingController(text: routeArgs?['name']);
    if (routeArgs == null) {
      edit = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: edit ? const Text('Neuer Kontakt') : const Text('Berbaiten'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              addVerticalSpace(10),
              edit
                  ? DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    )
                  : Text(''),
              // contactInputs('Name'),
              // if (category != "Intern") contactInputs('Firma'),
              // if (category == "Lieferant")
              //   contactInputs('Lieferanten-Nummer'),
              // if (category == "Lieferant")
              //   contactInputs('Unsere Kunden-Nummer'),
              // if (category == "Kunden") contactInputs('Kunden-Nummer'),
              // contactInputs('Strasse'),
              // contactInputs('PLZ'),
              // contactInputs('Ort'),
              // contactInputs('Telefon'),
              // contactInputs('Mobil'),
              // contactInputs('E-Mail'),

              TextFormField(
                controller: nameController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      firestoreService.addContact(
                          nameController.text, category);
                      // addContact(nameController.text);

                      // Navigator.pop(context);
                    },
                    child: const Text('Spiechern'),
                  ),
                  TextButton(
                      onPressed: () {
                        // editMode = true;
                        // final docUser = db
                        //     .collection('contacts')
                        //     .doc('G7zz3UnSiNJpqUpWJyF1')
                        //     .collection('Intern')
                        //     .doc('Re5IQ9826zG2CaTx1v14');
                        // docUser.update({'name': 'O lesh'});
                        // print(docUser);

                        // print(object)
                        // print(nameController.text);
                        // print(category);
                        print(contact.contactCategory);
                      },
                      child: const Text('Berbaiten'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
