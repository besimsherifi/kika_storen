import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/$text-screen');
      },
      child: Card(
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
      ),
    );
  }
}
