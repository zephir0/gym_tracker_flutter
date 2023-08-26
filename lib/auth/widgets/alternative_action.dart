import 'package:flutter/material.dart';

import '../auth_screen.dart';

class AlternativeAction extends StatelessWidget {
  final FormType formType;
  final void Function(FormType) onFormTypeChange;

  AlternativeAction(this.formType, this.onFormTypeChange);

  @override
  Widget build(BuildContext context) {
    switch (formType) {
      case FormType.login:
        return Column(
          children: [
            _buildForgotPasswordField(context),
            _buildSignUpField(context),
          ],
        );
      case FormType.forgotPassword:
      case FormType.signUp:
        return _buildBackToLoginFormField(context);
      default:
        return Container();
    }
  }

  Padding _buildForgotPasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => onFormTypeChange(FormType.forgotPassword),
          child: Text(
            "Forgot password?",
            style: TextStyle(
              color: Color.fromRGBO(43, 138, 132, 100),
              fontSize: 22,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSignUpField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't you have an account? ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Roboto',
              ),
            ),
            TextButton(
                onPressed: () => onFormTypeChange(FormType.signUp),
                child: Text("Signup",
                    style: TextStyle(
                        color: Color.fromRGBO(43, 138, 132, 100),
                        fontSize: 17,
                        fontFamily: 'Roboto'))),
          ],
        ),
      ),
    );
  }

  Padding _buildBackToLoginFormField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: () => onFormTypeChange(FormType.login),
            child: Text("Back to Login",
                style: TextStyle(
                    color: Color.fromRGBO(43, 138, 132, 100),
                    fontSize: 17,
                    fontFamily: 'Roboto'))),
      ),
    );
  }
}
