import 'package:flutter/material.dart';

class KontaktenScreen extends StatelessWidget {
  const KontaktenScreen({Key? key}) : super(key: key);

  static const routeName = '/Kontakte-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontakte'),
      ),
      body: Center(
        child: Text('Kontakte'),
      ),
    );
  }
}
