import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/helper_widgets.dart';
import 'aufgaben_list_screen.dart';

class AufgabenScreen extends StatelessWidget {
  const AufgabenScreen({Key? key}) : super(key: key);

  static const routeName = '/Aufgaben-screen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Aufgaben"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text('Willkommen zurück'),
                    ),
                    Text(
                      'Hier ist das heutige Update.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
              addVerticalSpace(20),
              Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Heute',
                    ),
                    Tab(
                      text: 'Geplant',
                    ),
                    Tab(
                      text: 'Erledigt',
                    ),
                    Tab(
                      text: 'Fehler',
                    )
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                children: [
                  AufgabenListScreen('Heute'),
                  AufgabenListScreen('geplant'),
                  AufgabenListScreen('erdeligt'),
                  AufgabenListScreen('fehler')
                ],
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Add-aufgaben-screen');
            },
            child: const Icon(Iconsax.add)),
      ),
    );
  }
}
