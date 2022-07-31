import 'package:flutter/material.dart';

class MenuItems {
  final String name;
  final Image image;

  MenuItems({required this.name, required this.image});

  static List<dynamic> menuItems() {
    var menu = [];

    menu.add(MenuItems(
        name: "Home",
        image: const Image(image: AssetImage('assets/images/home.png'))));
    menu.add(MenuItems(
        name: "Settings",
        image: const Image(image: AssetImage('assets/images/home.png'))));

    return menu;
  }
}
