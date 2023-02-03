import 'package:flutter/material.dart';
import 'package:kika_storen/widgets/button.dart';
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

  final firestoreService = FirestoreService();
  var editMode = true;
  bool activeBttn = false;

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    if (routeArgs == null) {
      editMode = false;
    }
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

    return Scaffold(
      appBar: AppBar(
        title: editMode ? const Text('Berbaiten') : const Text('Neuer Kontakt'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
          child: Column(
            children: [
              addVerticalSpace(10),
              const Icon(
                Icons.contact_page_outlined,
                size: 60,
              ),
              contactInputs("Name", nameController),
              contactInputs("Strasse", strasseController),
              if (contact.contactCategory != 'Intern')
                contactInputs("Firma", firmaController),
              if (contact.contactCategory == "Lieferanten")
                contactInputs("Lieferanten-Nummer", lieferantenNrController),
              if (contact.contactCategory == "Kunden")
                contactInputs("Kunden-Nummer", kundennNrController),
              contactInputs("PLZ", plzController),
              contactInputs("Ort", ortController),
              contactInputs("e-Mail", emailController),
              contactInputs("Mobil", mobilController),
              contactInputs("Telefon", telefonController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: nameController,
                    builder: (context, value, child) {
                      return Button(
                        label: 'Spiechern',
                        onTap: value.text.isNotEmpty
                            ? () {
                                if (!editMode) {
                                  firestoreService.createContact(
                                      category: contact.contactCategory,
                                      name: nameController.text,
                                      strasse: strasseController.text,
                                      firma: firmaController.text,
                                      lieferantenNr:
                                          lieferantenNrController.text,
                                      kundenNr: kundennNrController.text,
                                      plz: plzController.text,
                                      ort: ortController.text,
                                      telefon: telefonController.text,
                                      mobil: mobilController.text,
                                      email: emailController.text);
                                  showToast("Kontakt erfolgreich hinzugefügt");
                                  Navigator.pop(context);
                                } else {
                                  firestoreService.updateContact(
                                      id: routeArgs?['id'],
                                      category: contact.contactCategory,
                                      name: nameController.text,
                                      strasse: strasseController.text,
                                      firma: firmaController.text,
                                      lieferantenNr:
                                          lieferantenNrController.text,
                                      kundenNr: kundennNrController.text,
                                      plz: plzController.text,
                                      ort: ortController.text,
                                      telefon: telefonController.text,
                                      mobil: mobilController.text,
                                      email: emailController.text);
                                  showToast("Kontakt erfolgreich bearbeitet");
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              }
                            : null,
                      );
                    },
                  ),
                  addHorizontalSpace(10),
                  if (editMode)
                    Button(
                        onTap: () {
                          firestoreService.deleteContact(
                              id: routeArgs?['id'],
                              category: contact.contactCategory);
                          showToast("Kontakt erfolgreich gelöscht");
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        label: 'Löschen'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
