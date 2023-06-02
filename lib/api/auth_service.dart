import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/error_dialog.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
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
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to authenticate");
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
          duration: Duration(seconds: 2),
          content: Text("Successfully registered"),
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.popAndPushNamed(context, "/home");
    } else {
      ErrorDialog.showErrorDialog(context, "Failed to register");
    }
  }
}
