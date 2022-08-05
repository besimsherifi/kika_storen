import 'package:flutter/material.dart';
import 'package:kika_storen/utils/constants.dart';

class MenuItems {
  final String text;
  final Image image;

  MenuItems({required this.text, required this.image});

  static List<dynamic> menuItems() {
    var menu = [];


    menu.add(
      MenuItems(
        text: "Zeiterfassung",
        image: const Image(
          height: kMainScreenIconsSize,
          width: kMainScreenIconsSize,
          image: AssetImage('assets/images/clock.png'),
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Termine",
        image: const Image(
          width: kMainScreenIconsSize,
          height: kMainScreenIconsSize,
          image: AssetImage('assets/images/calendar.png'),
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Aufgaben",
        image: const Image(
          width: kMainScreenIconsSize,
          height: kMainScreenIconsSize,
          image: AssetImage('assets/images/tasks.png'),
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Projekten",
        image: const Image(
          width: kMainScreenIconsSize,
          height: kMainScreenIconsSize,
          image: AssetImage('assets/images/projects.png'),
        ),
      ),
    );
    menu.add(MenuItems(
        text: "Kontakte",
        image: const Image(
            width: kMainScreenIconsSize,
            height: kMainScreenIconsSize,
            image: AssetImage('assets/images/contact.png'))));
    menu.add(MenuItems(
        text: "Formularen",
        image: const Image(
            width: kMainScreenIconsSize,
            height: kMainScreenIconsSize,
            image: AssetImage('assets/images/formular.png'))));

    return menu;
  }
}
