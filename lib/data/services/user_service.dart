import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/token/token_receiver.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/error_dialog.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart'; 
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class UserService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  Future<void> attemptDeleteAccount(BuildContext context) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.users}/delete-account', 
        options: Options(
          headers: {
          },
        ),
      );

      _logger.d('Attempting to delete user account');

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false);
      }
    } catch (e) {
      _logger.e('Failed to delete account: $e');
      ErrorDialog.showErrorDialog(context, "Failed to delete account: $e");
    }
  }

  Future<void> attemptChangePassword(String oldPassword, String newPassword, BuildContext context) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-password', 
        data: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _logger.d('Attempting to change password');

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
    } catch (e) {
      _logger.e('Failed to change password: $e');
      ErrorDialog.showErrorDialog(context, "Failed to change password: $e");
    }
  }

  Future<void> attemptChangeEmail(String newEmail, BuildContext context) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-email', 
        data: jsonEncode({
          'email': newEmail,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _logger.d('Attempting to change email');

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
    } catch (e) {
      _logger.e('Failed to change email: $e');
      ErrorDialog.showErrorDialog(context, "Failed to change email: $e");
    }
  }

  Future<void> attemptChangeUsername(String newUsername, BuildContext context) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-username', 
        data: jsonEncode({
          'name': newUsername,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _logger.d('Attempting to change username');

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
    } catch (e) {
      _logger.e('Failed to change username: $e');
      ErrorDialog.showErrorDialog(context, "Failed to change username: $e");
    }
  }
}
