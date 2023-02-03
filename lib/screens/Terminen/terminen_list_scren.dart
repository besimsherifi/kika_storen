import 'package:flutter/material.dart';

class TerminenListScreen extends StatelessWidget {
  const TerminenListScreen(this.category);

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
