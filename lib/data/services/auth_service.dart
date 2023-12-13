import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_receiver.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/error_dialog.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> attemptLogin(
      String username, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/auth/login'),
      body: jsonEncode({
        'login': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      TokenStorage(secureStorage: FlutterSecureStorage())
          .saveToken(response.body);
      print(response.body);
      String? token =
          await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
      print(token);
      Navigator.popAndPushNamed(context, "/navi-bar");
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to authenticate");
    }
  }

  Future<void> attemptLogout(BuildContext context) async {
    String? token = await TokenReceiver().getToken();
    var url = GlobalVariables().backendApiAddress + 'api/auth/logout';

    final response = await http.post(
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

  Future<void> attemptRegister(String username, String email, String password,
      BuildContext context) async {
    final response = await http.post(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/auth/register'),
      body: jsonEncode({
        'login': username,
        'emailAddress': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(43, 138, 132, 100),
          duration: Duration(seconds: 3),
          content: Text(
            "Successfully registered",
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
      ErrorDialog.showErrorDialog(context, "Failed to register");
    }
  }
}
