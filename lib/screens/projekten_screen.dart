import 'package:flutter/material.dart';

class ProjektenScreen extends StatelessWidget {
  const ProjektenScreen({Key? key}) : super(key: key);

  static const routeName = '/Projekten-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projekten'),
      ),
      body: Center(
        child: Text('Projekten'),
      ),
    );
  }
}
