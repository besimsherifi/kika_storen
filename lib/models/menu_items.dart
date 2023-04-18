import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/utils/constants.dart';

class MenuItems {
  final String text;
  final Icon image;

  MenuItems({required this.text, required this.image});

  static List<dynamic> menuItems() {
    var menu = [];

    menu.add(
      MenuItems(
        text: "Zeiterfassung",
        image: const Icon(
          Iconsax.timer_1,
          size: kMainScreenIconsSize,
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Termine",
        image: const Icon(
          Iconsax.calendar_tick,
          size: kMainScreenIconsSize,
        ),
      ),
    );
    // menu.add(
    //   MenuItems(
    //     text: "Aufgaben",
    //     image: const Icon(
    //       Iconsax.task,
    //       size: kMainScreenIconsSize,
    //     ),
    //   ),
    // );
    menu.add(
      MenuItems(
          text: "Arbeitsplanung",
          image: const Icon(
            Iconsax.calendar,
            size: kMainScreenIconsSize,
          )),
    );
    menu.add(
      MenuItems(
        text: "Projekten",
        image: const Icon(
          Iconsax.rulerpen,
          size: kMainScreenIconsSize,
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Kontakte",
        image: const Icon(
          Iconsax.personalcard,
          size: kMainScreenIconsSize,
        ),
      ),
    );
    menu.add(
      MenuItems(
        text: "Regierapport",
        image: const Icon(
          Iconsax.document_text_1,
          size: kMainScreenIconsSize,
        ),
      ),
    );
    return menu;
  }
}
