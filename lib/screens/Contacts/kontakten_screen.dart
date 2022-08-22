import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/screens/Contacts/contacts_list_screen.dart';
import 'package:kika_storen/utils/helper_widgets.dart';

class KontaktenScreen extends StatelessWidget {
  const KontaktenScreen({Key? key}) : super(key: key);

  static const routeName = '/Kontakte-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Intern'),
                Tab(text: 'Extern'),
                Tab(text: 'Lieferanten'),
                Tab(text: 'Kunden'),
              ],
            ),
            title: const Text('Kontakten'),
          ),
          body: const TabBarView(
            children: [
              ContactsListScreen('Intern'),
              ContactsListScreen('Extern'),
              ContactsListScreen('Lieferanten'),
              ContactsListScreen('Kunden'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return Column(
                      children: [
                        addVerticalSpace(20),
                        DropdownButton(
                          // Initial Value
                          value: 0,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: [],

                          onChanged: null,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Firma',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Strasse',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'PLZ',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Ort',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Telefon',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mobil',
                          ),
                        ),
                        addVerticalSpace(20),
                        TextButton(onPressed: () {}, child: Text('Spiechern'))
                      ],
                    );
                  });
            },
            child: const Icon(Iconsax.add),
          ),
        ),
      ),
    );
  }
}
