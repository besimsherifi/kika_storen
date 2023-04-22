import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/screens/Contacts/add_contact_screen.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/button.dart';

import '../../services/firestore_service.dart';

class FormData {
  String blindCategory;
  String width;
  String height;

  FormData(this.blindCategory, this.width, this.height);
}

class AddProjektScreen extends StatefulWidget {
  const AddProjektScreen({Key? key}) : super(key: key);

  static const routeName = '/Add-projekt-screen';

  @override
  State<AddProjektScreen> createState() => _AddProjektState();
}

class _AddProjektState extends State<AddProjektScreen> {
  final firestoreService = FirestoreService();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();

  List<String> categories = ['Montage', 'Reparatur', 'Beratung'];
  List<String> blindCategories = [
    'Sonnenstoren',
    'Rollladen',
    'Lamellenstoren',
    'Sonnenstorenstoffe',
    'Sicherheitsfaltladen',
    'Insektenschutz',
    'Stoff-Rollo und Plissee',
    'Sonnenschirme',
    'Rolllamellen'
  ];

  String selectedCategory = 'Montage';
  String selectedUser = '';
  List<Map<String, dynamic>> columnsData = [];

  List<String> users = [];

  Future<void> fetchUsers() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection('Kunden')
        .get();
    final List<String> fetchedUsers =
        querySnapshot.docs.map<String>((doc) => doc['name'] as String).toList();
    setState(() {
      users = fetchedUsers;
      selectedUser = users[0];
    });
  }

  @override
  void initState() {
    fetchUsers();
    columnsData.add({
      'selectedBlind': 'Sonnenstoren',
      'width': '',
      'height': '',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Projekt'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              terminInputs(
                  title: "Name des Projekt",
                  hint: "Name",
                  controller: nameController,
                  maxLines: 1,
                  readOnly: false,
                  icon: const Icon(
                    Icons.abc,
                    color: Colors.grey,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.0,
                      ),
                      child: Text('Name des Kunden'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: users
                        .map((user) => DropdownMenuItem<String>(
                              value: user,
                              child: Text(
                                user,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ))
                        .toList(),
                    value: selectedUser,
                    onChanged: (String? value) {
                      setState(() {
                        selectedUser = value!;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Projekt Typ'),
                  ],
                ),
              ),
              addVerticalSpace(5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ))
                        .toList(),
                    value: selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    }),
              ),
              terminInputs(
                  title: "Standort",
                  hint: "Standort",
                  controller: addressController,
                  maxLines: 1,
                  readOnly: false,
                  icon: const Icon(
                    Icons.place,
                    color: Colors.grey,
                  )),
              Row(
                children: [
                  Expanded(
                    child: terminInputs(
                      title: "Anfang Datum",
                      hint: DateFormat.yMd().format(startDate).toString(),
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
                              startDate = pickDate;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: terminInputs(
                      title: "End Datum",
                      hint: DateFormat.yMd().format(endDate).toString(),
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
                              endDate = pickDate;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: columnsData.length,
                    itemBuilder: (context, index) {
                      final data = columnsData[index];
                      final selectedBlind = data['selectedBlind'];
                      final width = data['width'];
                      final height = data['height'];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('Storen Typ'),
                              ],
                            ),
                          ),
                          addVerticalSpace(5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: blindCategories
                                  .map(
                                    (category) => DropdownMenuItem<String>(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: selectedBlind,
                              onChanged: (value) {
                                setState(() {
                                  data['selectedBlind'] = value!;
                                });
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Breite (cm)',
                                  ),
                                  initialValue: width,
                                  onChanged: (value) {
                                    setState(() {
                                      data['width'] = value;
                                    });
                                  },
                                ),
                              ),
                              addHorizontalSpace(10),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Höhe (cm)'),
                                  initialValue: height,
                                  onChanged: (value) {
                                    setState(() {
                                      data['height'] = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        columnsData.add({
                          'selectedBlind': 'Sonnenstoren',
                          'width': '',
                          'height': '',
                        });
                      });
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0, top: 5),
                    child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: nameController,
                        builder: (context, value, child) {
                          return Button(
                            label: 'Speichern',
                            onTap: value.text.isNotEmpty
                                ? () {
                                    firestoreService.createProject(
                                        name: nameController.text,
                                        customer: selectedUser,
                                        category: selectedCategory,
                                        address: addressController.text,
                                        startDate: startDate,
                                        endDate: endDate,
                                        blinds: columnsData,
                                        notes: notesController.text);
                                    showToast(
                                        'Projekt erfolgreich hinzugefügt');
                                    Navigator.pop(context);
                                  }
                                : null,
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
