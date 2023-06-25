import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<String> fetchNameFromJson() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/users/logged-user');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['login'];
    } else {
      throw Exception('Failed to load name from JSON');
    }
  }
}
