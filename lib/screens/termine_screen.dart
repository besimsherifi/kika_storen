import 'package:flutter/material.dart';

class TermineScreen extends StatelessWidget {
  const TermineScreen({Key? key}) : super(key: key);

  static const routeName = '/Termine-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminen'),
      ),
      body: Center(
        child: Text('Terminen'),
      ),
    );
  }
}
