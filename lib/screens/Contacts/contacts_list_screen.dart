import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen(this.contact);

  final String contact;

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final contacts = FirebaseFirestore.instance
      .collection('test')
      .doc('zVDTxxrQTWPBh90B6EYa')
      .collection('Intern')
      .snapshots();
  dynamic data;

  @override
  void initState() {
    super.initState();
    readUsers();
  }

  readUsers() async {
    var db = FirebaseFirestore.instance.collection('test');
    data = db.doc('Extern').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: contacts,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            print(data);
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


