import 'package:flutter/material.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen(this.contact);

  final String contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(contact)),
    );
  }
}

//TODO shajfe pse duhet tkiesh ene kontakten screen po ene kontaken list