import 'package:flutter/material.dart';

import '../../utils/helper_widgets.dart';

class BlindsCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BlindsCard({required this.blind});
  // ignore: prefer_typing_uninitialized_variables
  final blind;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            blind['selectedBlind'],
            style: const TextStyle(fontSize: 17),
          ),
          addVerticalSpace(3),
          Row(
            children: [
              Text(blind['width']),
              const Text(
                '(b)',
                style: TextStyle(fontSize: 12),
              ),
              addHorizontalSpace(5),
              const Text('x'),
              addHorizontalSpace(5),
              Text(blind['height']),
              const Text('(h)', style: TextStyle(fontSize: 12)),
            ],
          ),
        ]),
      ),
    ]);
  }
}
