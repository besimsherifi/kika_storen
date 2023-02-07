import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TerminCard extends StatelessWidget {
  const TerminCard(
      {required this.name,
      required this.address,
      required this.time,
      required this.notes});

  final String name;
  final String address;
  final String time;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        height: 110,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: (const TextStyle(color: Colors.white)),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: VerticalDivider(
                width: 1,
                thickness: 0.5,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    print(address);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.place),
                      Text(address),
                    ],
                  ),
                ),
                Row(
                  children: [Icon(Icons.timer_outlined), Text(time)],
                ),
                Row(
                  children: [Icon(Icons.note), Text(notes)],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
