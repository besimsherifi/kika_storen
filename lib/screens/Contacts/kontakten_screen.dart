import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/screens/Contacts/add_contact_screen.dart';
import 'package:kika_storen/screens/Contacts/contacts_list_screen.dart';

class KontaktenScreen extends StatefulWidget {
  const KontaktenScreen({Key? key}) : super(key: key);

  static const routeName = '/Kontakte-screen';

  @override
  State<KontaktenScreen> createState() => _KontaktenScreenState();
}

class _KontaktenScreenState extends State<KontaktenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelPadding: EdgeInsets.all(0),
            tabs: [
              Tab(text: 'Intern'),
              Tab(text: 'Extern'),
              Tab(text: 'Lieferanten'),
              Tab(text: 'Kunden'),
            ],
          ),
          title: const Text('Kontakten'),
        ),
        body: TabBarView(
          children: [
            ContactsListScreen('Intern'),
            ContactsListScreen('Extern'),
            ContactsListScreen('Lieferanten'),
            ContactsListScreen('Kunden'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddContactScreen.routeName);
          },
          child: const Icon(Iconsax.add),
        ),
      ),
    ));
  }
}
