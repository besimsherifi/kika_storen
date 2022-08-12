import 'package:flutter/material.dart';

class FormularenScreen extends StatelessWidget {
  const FormularenScreen({Key? key}) : super(key: key);

  static const routeName = '/Formularen-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formularen'),
      ),
      body: Center(
        child: Text('Formularen'),
      ),
    );
  }
}
