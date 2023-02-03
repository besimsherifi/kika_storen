import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/Contacts/contact_details_output.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/Contact-detail-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/Add-contact-screen', arguments: routeArgs);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0, left: 10, right: 10),
                child: Card(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                            routeArgs?['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 25),
                          )),
                          Center(
                            child: Text(
                              routeArgs?['email'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          addVerticalSpace(20),
                          if (routeArgs?['firma'] != '')
                            const Text('Firma',
                                style: TextStyle(color: Colors.grey)),
                          Center(
                            child: Text(routeArgs?['firma']),
                          ),
                          addVerticalSpace(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.mail_outline,
                                  size: 40,
                                ),
                                onTap: () async {
                                  String email = routeArgs?['email'];
                                  String url = 'mailto:$email';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not send email to $email';
                                  }
                                },
                              ),
                              addHorizontalSpace(20),
                              GestureDetector(
                                child: const Icon(
                                  Icons.message_outlined,
                                  size: 40,
                                ),
                                onTap: () async {
                                  String phoneNumber = routeArgs?['mobil'];
                                  String url = "sms:$phoneNumber";
                                  await launchUrlString(url);
                                },
                              ),
                              addHorizontalSpace(20),
                              GestureDetector(
                                child: const Icon(
                                  Icons.whatsapp,
                                  size: 40,
                                ),
                                onTap: () async {
                                  var nr = routeArgs?['mobil'];
                                  nr = nr.toString().substring(1, 9);
                                  nr = '+389$nr';
                                  var contact = nr;
                                  var androidUrl =
                                      "whatsapp://send?phone=$contact";
                                  var iosUrl = "https://wa.me/$contact";

                                  try {
                                    if (Platform.isIOS) {
                                      await launchUrl(Uri.parse(iosUrl));
                                    } else {
                                      await launchUrl(Uri.parse(androidUrl));
                                    }
                                  } on Exception {
                                    ('WhatsApp is not installed.');
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            addVerticalSpace(10),
            if (routeArgs?['lieferantenNr'] != '')
              ContactDetailsOutput(
                  'Liefeanten-Nummer', routeArgs?['lieferantenNr']),
            if (routeArgs?['kundenNr'] != '')
              ContactDetailsOutput('Kunden-Nummer', routeArgs?['kundenNr']),
            ContactDetailsOutput('Strasse', routeArgs?['strasse']),
            ContactDetailsOutput('PLZ', routeArgs?['plz']),
            ContactDetailsOutput('Ort', routeArgs?['ort']),
            ContactDetailsOutput('Mobil', routeArgs?['mobil']),
            GestureDetector(
              child: ContactDetailsOutput('Telefon', routeArgs?['telefon']),
              onTap: () async {
                final Uri url = Uri(scheme: 'tel', path: '0038971880604');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
