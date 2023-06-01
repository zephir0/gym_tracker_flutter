import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            title: Center(child: Text('Failed to authenticate')),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                child: Text('RETRY'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
