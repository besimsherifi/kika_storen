import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/helper_widgets.dart';

class TerminColor extends StatefulWidget {
  TerminColor({Key? key}) : super(key: key);

  @override
  State<TerminColor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TerminColor> {
  var selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Aufgabe Farbe'),
            addVerticalSpace(8),
            Wrap(
              children: List<Widget>.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                        radius: 12,
                        backgroundColor: index == 0
                            ? Colors.red
                            : index == 1
                                ? Colors.blue
                                : index == 2
                                    ? Colors.green
                                    : Colors.purple,
                        child: selectedColor == index
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : Container()),
                  ),
                );
              }),
            )
          ],
        )
      ],
    );
  }
}
