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

Widget terminInputs({title, hint, controller, maxLines, icon, readOnly}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(title),
        ),
        Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 5, bottom: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: readOnly,
                    maxLines: maxLines,
                    autocorrect: false,
                    controller: controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: icon,
                )
              ],
            )),
      ],
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
