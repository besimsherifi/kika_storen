import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  const AuthInput(
      {Key? key,
      required this.passwordController,
      required this.obscure,
      required this.hint})
      : super(key: key);

  final TextEditingController passwordController;
  final bool obscure;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: passwordController,
            obscureText: obscure,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: hint),
          ),
        ),
      ),
    );
  }
}
