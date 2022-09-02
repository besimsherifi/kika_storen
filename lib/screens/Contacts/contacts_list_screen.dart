import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen(this.contact, {Key? key}) : super(key: key);

  final String contact;

  @override
  Widget build(BuildContext context) {
    final contacts = FirebaseFirestore.instance
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(contact)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: contacts,
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
            return ListTile(
              title: Text(data['name']),
            );
          }).toList(),
        );
      },
    );
  }
}

//TODO shajfe pse duhet tkiesh ene kontakten screen po ene kontaken list


