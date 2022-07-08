import 'package:flutter/material.dart';
import 'package:kika_storen/screens/auth_screen.dart';
import 'package:kika_storen/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kika Storen',
      theme: ThemeData(),
      home: const AuthScreen(),
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
      },
    );
  }
}
