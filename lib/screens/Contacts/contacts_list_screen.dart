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
  final Stream<QuerySnapshot> contacts =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    // print(contacts);
    super.initState();
    // readUsers();
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
            return ListTile(
              title: Text(data['name']),
              subtitle: Text('company'),
            );
          }).toList(),
        );
      },
    );
  }
}

//TODO shajfe pse duhet tkiesh ene kontakten screen po ene kontaken list

readUsers() async {
  // var data = await FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) {
  //   print(snapshot.docs.length);
  // });

  Stream collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  print(collectionStream);
}
