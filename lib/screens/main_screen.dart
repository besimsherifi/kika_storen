import 'package:flutter/material.dart';

import '../models/menu_items.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main-screen';

  final List menuItems = MenuItems.menuItems();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kika Storen'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: menuItems
                .map(
                  (menuItem) =>
                      MenuCard(icon: menuItem.image, text: menuItem.text),
                )
                .toList()
            // RaisedButton(
            //   onPressed: () async {
            //     // context.read<AuthenticationService>().singOut();
            //     if (menuItems != null) {
            //       for (var i = 0; i < menuItems.length; i++) {
            //         print(menuItems[i].name);
            //       }
            //     }
            //   },
            //   child: Text('LogOut'),
            // ),
            ,
          ),
        ),
      ),
    );

    // return CupertinoPageScaffold(
    //   child: Center(
    //     child: Text('Wilkomen'),
    //   ),
    // );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  final Image icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(children: [icon]),
          ),
          const SizedBox(height: 10),
          Text(text)
        ],
      ),
    );
  }
}
