import 'package:flutter/material.dart';

class AufgabenScreen extends StatelessWidget {
  const AufgabenScreen({Key? key}) : super(key: key);

  static const routeName = '/Aufgaben-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aufgaben'),
      ),
      body: Center(
        child: Text('Aufgaben'),
      ),
    );
  }
}
