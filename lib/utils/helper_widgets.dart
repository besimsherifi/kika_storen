import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black,
      fontSize: 16.0);
}
