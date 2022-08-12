import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../models/menu_items.dart';
import '../services/authentication_service.dart';
import '../utils/config.dart';
import '../widgets/menu_card.dart';

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
      drawer: Drawer(
          child: Column(
        children: [
          addVerticalSpace(90),
          TextButton(
              onPressed: () {
                currentTheme.switchTheme();
              },
              child:
                  currentTheme.isDark ? Icon(Iconsax.sun) : Icon(Iconsax.moon)),
          TextButton(
              onPressed: () {
                context.read<AuthenticationService>().singOut();
              },
              child: Icon(Iconsax.logout))
        ],
      )),
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
                  .toList()),
        ),
      ),
    );
  }
}
