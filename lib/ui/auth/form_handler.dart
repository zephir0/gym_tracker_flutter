import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_event.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/error_dialog.dart';


class FormHandler {
  bool _validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = new RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // void handleLogin(String email, String password, BuildContext context) {
  //   print("Logging in with Email: $email, Password: $password");
  //     context.read<AuthBloc>().add(LoginAttempt(username: email, password: password));
  // }

  // void handleForgotPassword(String email, BuildContext context) {
  //   print("Sending recovery email to: $email");
  //   if (!_validateEmail(email)) {
  //     ErrorDialog.showErrorDialog(context, "Invalid email address");
  //   } else {}
  // }

  // void handleSignUp(String username, String email, String password,
  //     String confirmPassword, BuildContext context) {
  //   if (confirmPassword != password) {
  //     ErrorDialog.showErrorDialog(context, "Passwords do not match");
  //   } else if (!_validateEmail(email)) {
  //     ErrorDialog.showErrorDialog(context, "Invalid email address");
  //   } else {
  //     context.read<AuthBloc>().add(RegisterAttempt(username: username, email: email, password: password));
  //   }
  // }
}
