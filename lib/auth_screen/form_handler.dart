import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/error_dialog.dart';

import '../api/auth_service.dart';

class FormHandler {
  bool _validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = new RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void handleLogin(String email, String password, BuildContext context) {
    print("Logging in with Email: $email, Password: $password");
    if (!_validateEmail(email)) {
      ErrorDialog.showErrorDialog(context, "Invalid email address");
    } else {
      AuthService().attemptLogin(email, password, context);
      Navigator.pushReplacementNamed(context, '/navi-bar');
    }
  }

  void handleForgotPassword(String email, BuildContext context) {
    print("Sending recovery email to: $email");
    if (!_validateEmail(email)) {
      ErrorDialog.showErrorDialog(context, "Invalid email address");
    } else {
      // Call the appropriate method here
    }
  }

  void handleSignUp(String username, String email, String password,
      String confirmPassword, BuildContext context) {
    if (confirmPassword != password) {
      ErrorDialog.showErrorDialog(context, "Passwords do not match");
    } else if (!_validateEmail(email)) {
      ErrorDialog.showErrorDialog(context, "Invalid email address");
    } else {
      AuthService().attemptRegister(username, email, password, context);
    }
  }
}
