import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/token/token_receiver.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/error_dialog.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> attemptDeleteAccount(BuildContext context) async {
    String? token = await TokenReceiver().getToken();
    var url = GlobalVariables().backendApiAddress + 'api/users/delete-account';

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route route) => false);
    }
  }

  Future<void> attemptChangePassword(
      String oldPassword, String newPassword, BuildContext context) async {
    String? token = await TokenReceiver().getToken();

    final response = await http.put(
      Uri.parse(
          GlobalVariables().backendApiAddress + 'api/users/change-password'),
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(43, 138, 132, 100),
          duration: Duration(seconds: 3),
          content: Text(
            "Successfully changed password to: $newPassword",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.popAndPushNamed(context, "/login");
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to change password");
    }
  }

  Future<void> attemptChangeEmail(String newEmail, BuildContext context) async {
    String? token = await TokenReceiver().getToken();

    final response = await http.put(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/users/change-email'),
      body: jsonEncode({
        'email': newEmail,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(43, 138, 132, 100),
          duration: Duration(seconds: 3),
          content: Text(
            "Successfully changed email to: $newEmail",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.popAndPushNamed(context, "/login");
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to change email");
    }
  }

  Future<void> attemptChangeUsername(
      String newUsername, BuildContext context) async {
    String? token = await TokenReceiver().getToken();

    final response = await http.put(
      Uri.parse(
          GlobalVariables().backendApiAddress + 'api/users/change-username'),
      body: jsonEncode({
        'name': newUsername,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(43, 138, 132, 100),
          duration: Duration(seconds: 3),
          content: Text(
            "Successfully changed name to: $newUsername",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.popAndPushNamed(context, "/login");
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to change username");
    }
  }
}
