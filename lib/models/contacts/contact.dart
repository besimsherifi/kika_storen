import 'package:flutter/material.dart';

class Contact {
  final String name;

  Contact(this.name);

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
