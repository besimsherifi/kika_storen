import 'package:flutter/material.dart';
import 'package:kika_storen/models/menu_items.dart';
import 'package:kika_storen/services/authentication_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main-screen';

  // final List<City> _allCities = City.allCities();
  final List menuItems = MenuItems.menuItems();
  Map test = {
    'name': 'Home',
    'value': AssetImage('assets/images/home.png'),
    'name': 'Settings',
    'value': AssetImage('assets/images/setting.png'),
  };

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
            children: [
              RaisedButton(
                onPressed: () {
                  // context.read<AuthenticationService>().singOut();
                  if (menuItems != null) {
                    for (var i = 0; i < menuItems.length; i++) {
                      print(menuItems[i]);
                    }
                  }
                },
                child: Text('LogOut'),
              ),
              // MenuCard(Icon(Icons.home), 'Home'),
              // MenuCard(Icon(Icons.settings), 'Settings'),
              // MenuCard(Icon(Icons.lock_clock), 'Clock'),
              // MenuCard(Icon(Icons.calendar_month), 'Calendar'),
              // MenuCard(Icon(Icons.done_all), 'Done All'),
              // MenuCard(Icon(Icons.done), 'Done'),
              test.map(
                (key, value) => MenuCard(value, key),
              )
            ],
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
  MenuCard(this.icon, this.text);

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
            child: Container(
              child: Stack(children: [icon]),
            ),
          ),
          const SizedBox(height: 10),
          Text(text)
        ],
      ),
    );
  }
}
