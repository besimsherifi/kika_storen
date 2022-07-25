import 'package:flutter/material.dart';

class AuthErrorMessage extends StatelessWidget {
  const AuthErrorMessage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfffD7B7B4),
            border: Border.all(color: Color.fromARGB(255, 229, 155, 150)),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.info_outline,
                  color: Color(0xffA42B29),
                ),
              ),
              Text(
                message,
                style: const TextStyle(color: Color(0xffA42B29)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
