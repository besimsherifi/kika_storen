import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/providers/contact_provider.dart';
import 'package:kika_storen/providers/timer_provider.dart';
import 'package:kika_storen/screens/Arbeitsplanung/arbeitsplanung_scree.dart';
import 'package:kika_storen/screens/Aufgaben/add_aufgaben_screen.dart';
import 'package:kika_storen/screens/Contacts/add_contact_screen.dart';
import 'package:kika_storen/screens/Contacts/contact_detail_screen.dart';
import 'package:kika_storen/screens/Terminen/add_termin_screen.dart';
import 'package:kika_storen/screens/Aufgaben/aufgaben_screen.dart';
import 'package:kika_storen/screens/auth_screen.dart';
import 'package:kika_storen/screens/formularen_screen.dart';
import 'package:kika_storen/screens/Contacts/kontakten_screen.dart';
import 'package:kika_storen/screens/main_screen.dart';
import 'package:kika_storen/screens/Projekten/projekten_screen.dart';
import 'package:kika_storen/screens/Terminen/termine_screen.dart';
import 'package:kika_storen/screens/zeiterfassung_screen.dart';
import 'package:kika_storen/services/authentication_service.dart';
import 'package:kika_storen/theme/theme_constants.dart';
import 'package:kika_storen/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        ),
        ChangeNotifierProvider<TimerProvider>(
          create: (_) => TimerProvider(),
        ),
        ChangeNotifierProvider<ContactProvider>(
          create: (_) => ContactProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('de')],
        debugShowCheckedModeBanner: false,
        title: 'Kika Storen',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: currentTheme.currentTheme(),
        home: const AuthenticationWrapper(),
        routes: {
          ZeiterfassungScreen.routeName: (context) =>
              const ZeiterfassungScreen(),
          TerminenScreen.routeName: (context) => TerminenScreen(),
          AddTerminScreen.routeName: (context) => const AddTerminScreen(),
          ArbeitsplanungScreen.routeName: (context) => ArbeitsplanungScreen(),
          AufgabenScreen.routeName: (context) => const AufgabenScreen(),
          AddAufgabenScreen.routeName: (context) => const AddAufgabenScreen(),
          ProjektenScreen.routeName: (context) => const ProjektenScreen(),
          KontaktenScreen.routeName: (context) => const KontaktenScreen(),
          FormularenScreen.routeName: (context) => const FormularenScreen(),
          AddContactScreen.routeName: (context) => const AddContactScreen(),
          ContactDetailScreen.routeName: (context) =>
              const ContactDetailScreen()
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return MainScreen();
    }
    return const AuthScreen();
  }
}
