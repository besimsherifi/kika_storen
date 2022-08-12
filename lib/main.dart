import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/screens/aufgaben_screen.dart';
import 'package:kika_storen/screens/auth_screen.dart';
import 'package:kika_storen/screens/formularen_screen.dart';
import 'package:kika_storen/screens/kontakten_screen.dart';
import 'package:kika_storen/screens/main_screen.dart';
import 'package:kika_storen/screens/projekten_screen.dart';
import 'package:kika_storen/screens/termine_screen.dart';
import 'package:kika_storen/screens/zeiterfassung_screen.dart';
import 'package:kika_storen/services/authentication_service.dart';
import 'package:kika_storen/theme/theme_constants.dart';
import 'package:kika_storen/utils/config.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kika Storen',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: currentTheme.currentTheme(),
        home: AuthenticationWrapper(),
        routes: {
          ZeiterfassungScreen.routeName: (context) => ZeiterfassungScreen(),
          TermineScreen.routeName: (context) => TermineScreen(),
          AufgabenScreen.routeName: (context) => AufgabenScreen(),
          ProjektenScreen.routeName: (context) => ProjektenScreen(),
          KontaktenScreen.routeName: (context) => KontaktenScreen(),
          FormularenScreen.routeName: (context) => FormularenScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return MainScreen();
    }
    return AuthScreen();
  }
}
