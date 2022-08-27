import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget contactInputs(String value, TextEditingController controllerValue) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controllerValue,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: value,
      ),
    ),
  );
}
