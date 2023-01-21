import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/providers/contact_provider.dart';
import 'package:provider/provider.dart';
import '../../services/firestore_service.dart';

class ContactsListScreen extends StatelessWidget {
  ContactsListScreen(this.category, {Key? key}) : super(key: key);

  final String category;
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false);
    contact.contactCategory = category;

    // final contacts =
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getContacts(category),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/Add-contact-screen', arguments: data);
              },
              child: ListTile(
                title: Text(data['name']),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

//TODO shajfe pse duhet tkiesh ene kontakten screen po ene kontaken list
