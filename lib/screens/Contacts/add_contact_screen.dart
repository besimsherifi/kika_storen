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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  final firestoreService = FirestoreService();
  var edit = false;
  // String category = '';

  @override
  void didChangeDependencies() {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    final nameController = TextEditingController(text: routeArgs?['name']);
    final strasseController =
        TextEditingController(text: routeArgs?['strasse']);
    final firmaController = TextEditingController(text: routeArgs?['firma']);
    final lieferantenNrController =
        TextEditingController(text: routeArgs?['lieferantenNr']);
    final kundennNrController =
        TextEditingController(text: routeArgs?['kundenNr']);
    final plzController = TextEditingController(text: routeArgs?['plz']);
    final ortController = TextEditingController(text: routeArgs?['ort']);
    final mobilController = TextEditingController(text: routeArgs?['mobil']);
    final emailController = TextEditingController(text: routeArgs?['email']);
    final telefonController =
        TextEditingController(text: routeArgs?['telefon']);

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
              // edit
              //     ? DropdownButton(
              //         value: contact.contactCategory,
              //         icon: const Icon(Icons.keyboard_arrow_down),
              //         items: dropdownItems,
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             category = newValue!;
              //           });
              //         },
              //       )
              //     : const Text(''),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: strasseController,
                decoration: const InputDecoration(labelText: "Strasse"),
              ),
              if (contact.contactCategory != "Intern")
                TextFormField(
                  controller: firmaController,
                  decoration: const InputDecoration(labelText: "Firma"),
                ),
              if (contact.contactCategory == "Lieferanten")
                TextFormField(
                  controller: lieferantenNrController,
                  decoration:
                      const InputDecoration(labelText: "Lieferanten-Nummer"),
                ),
              if (contact.contactCategory == "Kunden")
                TextFormField(
                  controller: kundennNrController,
                  decoration: const InputDecoration(labelText: "Kunden-Nummer"),
                ),
              TextFormField(
                controller: plzController,
                decoration: const InputDecoration(labelText: "PLZ"),
              ),
              TextFormField(
                controller: ortController,
                decoration: const InputDecoration(labelText: "Ort"),
              ),
              TextFormField(
                controller: telefonController,
                decoration: const InputDecoration(labelText: "Telefon"),
              ),
              TextFormField(
                controller: mobilController,
                decoration: const InputDecoration(labelText: "Mobil"),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "e-Mail"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      firestoreService.createContact(
                          category: contact.contactCategory,
                          name: nameController.text,
                          strasse: strasseController.text,
                          firma: firmaController.text,
                          lieferantenNr: lieferantenNrController.text,
                          kundenNr: kundennNrController.text,
                          plz: plzController.text,
                          ort: ortController.text,
                          telefon: telefonController.text,
                          mobil: mobilController.text,
                          email: emailController.text);
                      // Navigator.pop(context);
                    },
                    child: const Text('Spiechern'),
                  ),
                  TextButton(
                      onPressed: () {
                        // editMode = true;
                        firestoreService.updateContact(
                            id: routeArgs?['id'],
                            category: contact.contactCategory,
                            name: nameController.text,
                            strasse: strasseController.text,
                            firma: firmaController.text,
                            lieferantenNr: lieferantenNrController.text,
                            kundenNr: kundennNrController.text,
                            plz: plzController.text,
                            ort: ortController.text,
                            telefon: telefonController.text,
                            mobil: mobilController.text,
                            email: emailController.text);
                        // print(docUser);

                        // print(object)
                        // print(nameController.text);
                        print(contact.contactCategory);
                        print(routeArgs?['id']);
                        // print(contact.contactCategory);
                      },
                      child: const Text('Berbaiten')),
                  TextButton(
                      onPressed: () {
                        firestoreService.deleteContact(
                            id: routeArgs?['id'],
                            category: contact.contactCategory);
                      },
                      child: Text('Loschen'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
