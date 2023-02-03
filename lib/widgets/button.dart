import 'package:flutter/material.dart';
import 'package:kika_storen/utils/constants.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kKikaBlueColor),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
