import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kika_storen/screens/main_screen.dart';
import 'package:kika_storen/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65),
                        child:
                            Image(image: AssetImage('assets/images/logo.png')),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Willkommen',
                        style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(fontSize: 20),
                            color: const Color(0xff164276),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'username'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'password'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kKikaBlueColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(MainScreen.routeName),
                            child: Text(
                              'Anmelden',
                              style: GoogleFonts.robotoSlab(
                                textStyle: const TextStyle(
                                  color: kKikaBlueTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
