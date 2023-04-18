import 'package:flutter/material.dart';
import 'package:kika_storen/screens/Formularen/regierapport_screen.dart';
import 'package:kika_storen/utils/constants.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FormularenScreen extends StatelessWidget {
  FormularenScreen({Key? key}) : super(key: key);

  static const routeName = '/Regierapport-screen';
  final List<String> forms = [
    'Regierapport',
  ];
  final image = imageFromAssetBundle('assets/homeLogo.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Regierapport'),
        ),
        body: Column(
          children: forms
              .map(
                (form) => GestureDetector(
                  onTap: () {
                    // _displayPdf(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegieRapportScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.description),
                        addHorizontalSpace(10),
                        Text(
                          form,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ));
  }
}

void _createPdf() async {
  final doc = pw.Document();

  /// for using an image from assets
  final image = await imageFromAssetBundle('assets/homeLogo.png');

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Row(children: [pw.Image(image, width: 100, height: 100)])
          ],
        );
      },
    ),
  ); // Page

  /// print the document using the iOS or Android print service:
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());

  /// share the document to other applications:
  // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

  /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
  /// save PDF with Flutter library "path_provider":
  // final output = await getTemporaryDirectory();
  // final file = File('${output.path}/example.pdf');
  // await file.writeAsBytes(await doc.save());
}

void _displayPdf(context) async {
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
                  child: pw.Text(
                    'Rapport',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
                  child: pw.Text(
                    'Auftrags-Nr',
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
                  child: pw.Text(
                    'Auftraggeber',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
                  child: pw.Text('Datum Kundentermin:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
                  child: pw.Text(
                    'Rechnungsadresse:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
                  child: pw.Text('Bauobjekt:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
                  height: kRegierapportFormHeight,
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
                  height: kRegierapportFormHeight,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(children: [
                    pw.Row(children: [
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Rolllanden'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Raff-Lamellenstoren'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Faltrollladen')
                    ]),
                    pw.Row(children: [
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Sonnenstoren'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Sicherheitsfaltladen'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Rolllamellenstoren')
                    ]),
                    pw.Row(children: [
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Insektenschutz'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Stoff-Rollo und Plissee'),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Zip Storen')
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
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Küche'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Schlafzimmer'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Kinderzimmer'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Badezimmer'),
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
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Fenster'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Türe'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Balkon'),
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
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Gurt'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Kurbel'),
                  pw.SizedBox(width: 5),
                  pw.Checkbox(value: false, name: '', height: 10, width: 10),
                  pw.SizedBox(width: 2),
                  pw.Text('Motor'),
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
                  child: pw.Text(
                    'Arbeitsbeschrieb:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
                        'Demontage',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Ja',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 5),
                      pw.Checkbox(
                          value: false, name: '', height: 10, width: 10),
                      pw.SizedBox(width: 2),
                      pw.Text('Nein',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 5),
                      pw.Text('Anz. MA:___',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
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
                        'Montage von Anz. MA:___',
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
                  child: pw.Text(
                    'Materialverbrauch:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
              pw.Text('Fertig verrechnen',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(width: 5),
              pw.Checkbox(value: false, name: '', height: 10, width: 10),
              pw.SizedBox(width: 2),
              pw.Text('JA'),
              pw.SizedBox(width: 5),
              pw.Checkbox(value: false, name: '', height: 10, width: 10),
              pw.SizedBox(width: 2),
              pw.Text('NEIN'),
              pw.SizedBox(width: 5),
              pw.Checkbox(value: false, name: '', height: 10, width: 10),
              pw.SizedBox(width: 2),
              pw.Text('GARANTIE'),
            ]),
            pw.SizedBox(height: 20),
            pw.Row(children: [
              pw.Text('Datum:________'),
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
