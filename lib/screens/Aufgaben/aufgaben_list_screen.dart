import 'package:flutter/material.dart';

class AufgabenListScreen extends StatelessWidget {
  const AufgabenListScreen(this.category);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text(category)),
          ],
        ),
      ),
    );
  }
}
