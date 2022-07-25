import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kika_storen/utils/constants.dart';
import 'package:kika_storen/widgets/auth_error_msg.dart';
import 'package:kika_storen/widgets/auth_input.dart';
import 'package:provider/provider.dart';

import '../services/authentication_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var message = '';

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
                      AuthInput(
                          passwordController: emailController,
                          obscure: false,
                          hint: 'e-mail'),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthInput(
                        passwordController: passwordController,
                        obscure: true,
                        hint: 'kenwort',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (message != '') AuthErrorMessage(message: message),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kKikaBlueColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            onPressed: () async {
                              var res = await context
                                  .read<AuthenticationService>()
                                  .singIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                              print(res);
                              setState(() {
                                if (res != null) {
                                  message = res;
                                }
                              });
                            },
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
