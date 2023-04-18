import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../utils/constants.dart';

class RegieRapportScreen extends StatefulWidget {
  RegieRapportScreen({Key? key}) : super(key: key);

  @override
  State<RegieRapportScreen> createState() => _RegieRapportScreenState();
}

class _RegieRapportScreenState extends State<RegieRapportScreen> {
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

  List<String> roomTypes = [
    'Küche',
    'Schlafzimmer',
    'Kinderzimmer',
    'Badezimmer',
  ];

  List<String> doorType = [
    'Fenster',
    'Türe',
    'Balkon',
  ];

  List<String> movement = [
    'Gurt',
    'Kurbel',
    'Motor',
  ];

  final rapportController = TextEditingController();
  final auftragsNrController = TextEditingController();
  final auftraggeberController = TextEditingController();
  DateTime datumKundenTermin = DateTime.now();
  final rechnungsadresseController = TextEditingController();
  final bauobjektController = TextEditingController();
  String produktetyp = 'Sonnenstoren';
  String zimmerart = 'Küche';
  String lichtart = 'Fenster';
  String antrieb = 'Gurt';
  final arbeitsbeschreibController = TextEditingController();
  bool demontage = false;
  final demontageNr = TextEditingController();
  final montageNr = TextEditingController();
  final materialVerbrauchController = TextEditingController();
  final monteurController = TextEditingController();
  final arbeitszeitController = TextEditingController();
  final fahrzeitController = TextEditingController();
  String fertigVerechnen = 'Ja';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neues Regierapport'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              terminInputs(
                  title: 'Rapport',
                  hint: '',
                  controller: rapportController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Auftrags-NR',
                  hint: '',
                  controller: auftragsNrController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Auftragegebber',
                  hint: '',
                  controller: auftraggeberController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                title: "Datum Kundentermin",
                hint: DateFormat.yMd().format(datumKundenTermin).toString(),
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
                        datumKundenTermin = pickDate;
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
                  title: 'Rechnungsadresse:',
                  hint: '',
                  controller: rechnungsadresseController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Bauobjekt:',
                  hint: '',
                  controller: bauobjektController,
                  maxLines: 1,
                  readOnly: false),
              addVerticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Produktetyp'),
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
                        items: blindCategories
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ))
                            .toList(),
                        value: produktetyp,
                        onChanged: (String? value) {
                          setState(() {
                            produktetyp = value!;
                          });
                        }),
                  ),
                ],
              ),
              addVerticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Zimmerart'),
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
                        items: roomTypes
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ))
                            .toList(),
                        value: zimmerart,
                        onChanged: (String? value) {
                          setState(() {
                            zimmerart = value!;
                          });
                        }),
                  ),
                ],
              ),
              addVerticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Licht Art'),
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
                        items: doorType
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ))
                            .toList(),
                        value: lichtart,
                        onChanged: (String? value) {
                          setState(() {
                            lichtart = value!;
                          });
                        }),
                  ),
                ],
              ),
              addVerticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Antrieb'),
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
                        items: movement
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ))
                            .toList(),
                        value: antrieb,
                        onChanged: (String? value) {
                          setState(() {
                            antrieb = value!;
                          });
                        }),
                  ),
                ],
              ),
              terminInputs(
                  title: 'Arbeitsbeschrieb',
                  hint: '',
                  controller: arbeitsbeschreibController,
                  maxLines: 1,
                  readOnly: false),
              addVerticalSpace(10),
              Row(
                children: [
                  Text('Demontage'),
                  Radio(
                    value: true,
                    groupValue: demontage,
                    onChanged: (value) {
                      setState(() {
                        demontage = true;
                        print(demontage);
                      });
                    },
                  ),
                  Text('Ja'),
                  Radio(
                    value: false,
                    groupValue: demontage,
                    onChanged: (value) {
                      setState(() {
                        demontage = false;
                        print(demontage);
                      });
                    },
                  ),
                  Text('Nein'),
                ],
              ),
              demontage
                  ? terminInputs(
                      title: 'Demontage Anz. MA',
                      hint: '',
                      controller: demontageNr,
                      maxLines: 1,
                      readOnly: false)
                  : Container(),
              terminInputs(
                  title: 'Montage von Anz. MA',
                  hint: '',
                  controller: montageNr,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Materialverbrauch',
                  hint: '',
                  controller: materialVerbrauchController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Monteur',
                  hint: '',
                  controller: monteurController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Arbeitszeit',
                  hint: '',
                  controller: arbeitszeitController,
                  maxLines: 1,
                  readOnly: false),
              terminInputs(
                  title: 'Fahrzeit',
                  hint: '',
                  controller: fahrzeitController,
                  maxLines: 1,
                  readOnly: false),
              addVerticalSpace(10),
              Row(
                children: [
                  Text('Fertig verrechnen'),
                  Radio(
                    value: 'Ja',
                    groupValue: fertigVerechnen,
                    onChanged: (value) {
                      setState(() {
                        fertigVerechnen = 'Ja';
                      });
                    },
                  ),
                  Text('Ja'),
                  Radio(
                    value: 'Nein',
                    groupValue: fertigVerechnen,
                    onChanged: (value) {
                      setState(() {
                        fertigVerechnen = 'Nein';
                      });
                    },
                  ),
                  Text('Nein'),
                  Radio(
                    value: 'Garantie',
                    groupValue: fertigVerechnen,
                    onChanged: (value) {
                      setState(() {
                        fertigVerechnen = 'Garantie';
                      });
                    },
                  ),
                  Text('Garantie'),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _displayPdf(
                      context,
                      rapportController.text,
                      auftragsNrController.text,
                      auftraggeberController.text,
                      rechnungsadresseController.text,
                      bauobjektController.text,
                      datumKundenTermin,
                      produktetyp,
                      zimmerart,
                      lichtart,
                      antrieb,
                      arbeitsbeschreibController.text,
                      demontage,
                      demontageNr.text,
                      montageNr.text,
                      materialVerbrauchController.text,
                      monteurController.text,
                      fertigVerechnen,
                      arbeitszeitController.text,
                      fahrzeitController.text,
                    );
                  },
                  child: Text('Print'))
            ],
          ),
        ),
      ),
    );
  }
}

void _displayPdf(
    context,
    name,
    auftragnr,
    auftraggebber,
    rechnugsadresse,
    bauobjekt,
    datumkundentermin,
    produktetyp,
    zimerart,
    lichtart,
    antrieb,
    arbeitsbeschreib,
    demontage,
    demontageNr,
    montageNr,
    materialverbrauch,
    monteur,
    fertigverechnen,
    arbeitszeit,
    fahrzeit) async {
  final image = await imageFromAssetBundle('assets/homeLogo.png');
  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(image, width: 100, height: 100),
              pw.Column(
                children: [
                  pw.Row(children: [
                    pw.Text('Kika Storen GmbH | ',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Maneggplatz 18 | '),
                    pw.Text('8041 Zürich'),
                  ]),
                  pw.Row(children: [
                    pw.Text('+41 76 439 04 45 / +41 79 531 31 13 18 | '),
                    pw.Text('info@kikastoren.ch')
                  ]),
                  pw.Row(children: [
                    pw.Text('www.kikastoren.ch  CHE -409.413.511'),
                  ]),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Column(children: [
            pw.Row(
              children: [
                pw.Container(
                  width: 225,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Rapport: ',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(name)
                    ],
                  ),
                ),
                pw.Container(
                  width: 225,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Text('Auftrags-Nr. ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(auftragnr)
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 225,
                  height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Auftraggeber:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(auftraggebber)
                    ],
                  ),
                ),
                pw.Container(
                  width: 225,
                  height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Datum Kundentermin: ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(DateFormat('dd.MM.yyyy')
                          .format(datumkundentermin)
                          .toString())
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 225,
                  height: kRegierapportFormHeight + 10,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Rechnungsadresse:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(rechnugsadresse)
                    ],
                  ),
                ),
                pw.Container(
                  width: 225,
                  height: kRegierapportFormHeight + 10,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Bauobjekt:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(bauobjekt)
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 100,
                  // height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Text(
                    'Produktetyp',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  width: 350,
                  // height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(children: [
                    pw.Row(children: [
                      pw.Text(produktetyp)
                      //   pw.Checkbox(
                      //       value: true,
                      //       name: 'rolllanden',
                      //       height: 10,
                      //       width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Rolllanden'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Raff-Lamellenstoren'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Faltrollladen')
                      // ]),
                      // pw.Row(children: [
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Sonnenstoren'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Sicherheitsfaltladen'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Rolllamellenstoren')
                      // ]),
                      // pw.Row(children: [
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Insektenschutz'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Stoff-Rollo und Plissee'),
                      //   pw.SizedBox(width: 5),
                      //   pw.Checkbox(
                      //       value: false, name: '', height: 10, width: 10),
                      //   pw.SizedBox(width: 2),
                      //   pw.Text('Zip Storen')
                    ]),
                  ]),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(children: [
              pw.Container(
                width: 100,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Text(
                  'Zimmerart',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Container(
                width: 350,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Row(children: [
                  pw.Text(zimerart)
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Küche'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Schlafzimmer'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Kinderzimmer'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Badezimmer'),
                ]),
              ),
            ]),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(children: [
              pw.Container(
                width: 100,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Text(
                  'Licht Art',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Container(
                width: 350,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Row(children: [
                  pw.Text(lichtart)
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Fenster'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Türe'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Balkon'),
                ]),
              ),
            ]),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(children: [
              pw.Container(
                width: 100,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Text(
                  'Antrieb',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Container(
                width: 350,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1.0,
                  ),
                ),
                child: pw.Row(children: [
                  pw.Text(antrieb)
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Gurt'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Kurbel'),
                  // pw.SizedBox(width: 5),
                  // pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  // pw.SizedBox(width: 2),
                  // pw.Text('Motor'),
                ]),
              ),
            ]),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 450,
                  height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Arbeitsbeschrieb:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(arbeitsbeschreib)
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 450,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Demontage ',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      // pw.SizedBox(
                      //   width: 10,
                      // ),
                      // pw.Checkbox(
                      //     value: false, name: '', height: 10, width: 10),
                      // pw.SizedBox(width: 2),
                      // pw.Text('Ja',
                      //     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      // pw.SizedBox(width: 5),
                      // pw.Checkbox(
                      //     value: false, name: '', height: 10, width: 10),
                      // pw.SizedBox(width: 2),
                      // pw.Text('Nein',
                      //     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      // pw.SizedBox(width: 5),
                      demontage
                          ? pw.Text('Anz. MA: $demontageNr',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold))
                          : pw.Text('Nein'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 450,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Montage von Anz. MA: $montageNr',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 450,
                  height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Materialverbrauch:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(materialverbrauch)
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('Datum',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('Monteur',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('Arbeitszeit',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('Fahrzeit',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(DateFormat('dd.MM.yyyy')
                          .format(datumkundentermin)
                          .toString())
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        monteur,
                      )
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [pw.Text(arbeitszeit)],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [pw.Text(fahrzeit)],
                  ),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
                pw.Container(
                  width: 112.5,
                  height: 12,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text('',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 15),
            pw.Row(children: [
              pw.Text('Fertig verrechnen ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(fertigverechnen)

              // pw.SizedBox(width: 5),
              // pw.Checkbox(value: false, name: '', height: 10, width: 10),
              // pw.SizedBox(width: 2),
              // pw.Text('JA'),
              // pw.SizedBox(width: 5),
              // pw.Checkbox(value: false, name: '', height: 10, width: 10),
              // pw.SizedBox(width: 2),
              // pw.Text('NEIN'),
              // pw.SizedBox(width: 5),
              // pw.Checkbox(value: false, name: '', height: 10, width: 10),
              // pw.SizedBox(width: 2),
              // pw.Text('GARANTIE'),
            ]),
            pw.SizedBox(height: 20),
            pw.Row(children: [
              pw.Text(
                  'Datum: ${DateFormat('dd.MM.yyyy').format(datumkundentermin).toString()}'),
              pw.SizedBox(width: 10),
              pw.Text('Unterschrift Kunde:________'),
              pw.SizedBox(width: 10),
              pw.Text('Unterschrift Monteur:________')
            ])
          ])
        ]);
      },
    ),
  );

  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ));

  // void generatePdf() async {
  //   const title = 'eclectify Demo';
  //   await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  // }
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "regierapport.pdf",
      ),
    );
  }
}
