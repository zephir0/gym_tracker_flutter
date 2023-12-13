import 'package:flutter/material.dart';

import '../auth_page.dart';

class ShortDescription extends StatelessWidget {
  final FormType formType;

  ShortDescription(this.formType);

  @override
  Widget build(BuildContext context) {
    String text = "";
    switch (formType) {
      case FormType.login:
        text = "LOGIN";
        break;
      case FormType.forgotPassword:
        text = "RECOVER PASSWORD";
        break;
      case FormType.signUp:
        text = "SIGN UP";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              "Please enter your details to continue.",
              style: TextStyle(
                color: Color.fromRGBO(126, 120, 120, 100),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
