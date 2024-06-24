import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/token/token_receiver.dart';
import 'package:gym_tracker_flutter/core/token/token_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  final Dio _dio = Dio();

  Future<bool> attemptLogin(String username, String password) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.authentication}/login',
        data: {
          'login': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        await TokenStorage(secureStorage: FlutterSecureStorage()).saveToken(response.data);
        return true; 
      } else {
        return false; 
      }
    } catch (e) {
      print("Error during login: $e");
      return false; 
    }
  }

  Future<void> attemptLogout() async {
    try {
      String? token = await TokenReceiver().getToken();
      final response = await _dio.post(
        '${ApiEndpoints.authentication}/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        
      } else {
        throw Exception("Failed to logout");
      }
    } catch (e) {
      print("Error during logout: $e");
      throw Exception("Failed to logout");
    }
  }

  Future<void> attemptRegister(String username, String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.authentication}/register',
        data: {
          'login': username,
          'emailAddress': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      print("Error during registration: $e");
      throw Exception("Failed to register");
    }
  }
}
