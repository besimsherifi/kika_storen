import 'package:flutter/material.dart';

class MenuItems {
  final String text;
  final Image image;

  MenuItems({required this.text, required this.image});

  static List<dynamic> menuItems() {
    var menu = [];


    menu.add(
      MenuItems(
        text: "Home",
        image: const Image(
          image: AssetImage('assets/images/home.png'),
        ),
      ),
    );
    menu.add(MenuItems(
        text: "Settings",
        image: const Image(image: AssetImage('assets/images/settings.png'))));
    menu.add(MenuItems(
        text: "Home",
        image: const Image(image: AssetImage('assets/images/home.png'))));
    menu.add(MenuItems(
        text: "Settings",
        image: const Image(image: AssetImage('assets/images/settings.png'))));
    menu.add(MenuItems(
        text: "Home",
        image: const Image(image: AssetImage('assets/images/home.png'))));
    menu.add(MenuItems(
        text: "Settings",
        image: const Image(image: AssetImage('assets/images/settings.png'))));

    return menu;
  }
}
