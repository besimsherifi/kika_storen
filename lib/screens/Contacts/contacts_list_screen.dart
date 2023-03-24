import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kika_storen/providers/contact_provider.dart';
import 'package:kika_storen/screens/Contacts/contact_detail_screen.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/firestore_service.dart';

class ContactsListScreen extends StatelessWidget {
  ContactsListScreen(this.category, {Key? key}) : super(key: key);

  final String category;
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    contact.contactCategory = category;

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getContacts(category),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Lade"));
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Keine Kontakte'),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    onPressed: (context) {
                      firestoreService.deleteContact(
                          id: data['id'], category: contact.contactCategory);
                      showToast('Kontakt erfolgreich gelöscht');
                    },
                    icon: Icons.delete,
                  )
                ]),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Icon(Icons.person),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ContactDetailScreen.routeName,
                                  arguments: data);
                            },
                            child: ListTile(
                              title: Text(data['name']),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.call),
                          onTap: () async {
                            final Uri url =
                                Uri(scheme: 'tel', path: data['mobil']);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              return;
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

//TODO shajfe pse duhet tkiesh ene kontakten screen po ene kontaken list