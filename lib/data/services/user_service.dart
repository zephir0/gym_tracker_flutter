import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class UserService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  Future<String> fetchUserInfoFromJson() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}/users/logged-user');
      if (response.statusCode == 200) {
        return response.data['login'];
      } else {
        _logger.e('Failed to fetch user info');
        throw Exception('Failed to fetch user info');
      }
    } catch (e) {
      _logger.e('Failed to fetch user info: $e');
      throw Exception('Failed to fetch user info: $e');
    }
  }

  Future<void> attemptDeleteAccount() async {
    try {
      Response response = await _dio.delete('${ApiEndpoints.users}/delete-account');
      _logger.d('Attempting to delete user account');

      if (response.statusCode != 200) {
        _logger.e('Failed to delete account');
        throw Exception('Failed to delete account');
      }
    } catch (e) {
      _logger.e('Failed to delete account: $e');
      throw Exception('Failed to delete account: $e');
    }
  }

  Future<void> attemptChangePassword(String oldPassword, String newPassword) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-password',
        data: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      _logger.d('Attempting to change password');

      if (response.statusCode != 200) {
        _logger.e('Failed to change password');
        throw Exception('Failed to change password');
      }
    } catch (e) {
      _logger.e('Failed to change password: $e');
      throw Exception('Failed to change password: $e');
    }
  }

  Future<void> attemptChangeEmail(String newEmail) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-email',
        data: jsonEncode({
          'email': newEmail,
        }),
      );

      _logger.d('Attempting to change email');

      if (response.statusCode != 200) {
        _logger.e('Failed to change email');
        throw Exception('Failed to change email');
      }
    } catch (e) {
      _logger.e('Failed to change email: $e');
      throw Exception('Failed to change email: $e');
    }
  }

  Future<void> attemptChangeUsername(String newUsername) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.users}/change-username',
        data: jsonEncode({
          'name': newUsername,
        })
      );

      _logger.d('Attempting to change username');

      if (response.statusCode != 200) {
        _logger.e('Failed to change username');
        throw Exception('Failed to change username');
      }
    } catch (e) {
      _logger.e('Failed to change username: $e');
      throw Exception('Failed to change username: $e');
    }
  }
}
