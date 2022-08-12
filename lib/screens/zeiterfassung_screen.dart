import 'package:flutter/material.dart';

class ZeiterfassungScreen extends StatelessWidget {
  const ZeiterfassungScreen({Key? key}) : super(key: key);

  static const routeName = '/Zeiterfassung-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zeiterfassung'),
      ),
      body: Center(
        child: Text('Zeiterfassung'),
      ),
    );
  }
}
