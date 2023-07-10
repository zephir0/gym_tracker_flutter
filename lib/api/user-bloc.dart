import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../token/token_storage.dart';
import '../utills/global_variables.dart';

class UserBloc {
  final _nameController = StreamController<String>.broadcast();

  Stream<String> get name => _nameController.stream;

  void fetchNameFromJson() async {
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
      _nameController.sink.add(jsonResponse['login']);
    } else {
      _nameController.sink.addError('Failed to load name from JSON');
    }
  }

  void dispose() {
    _nameController.close();
  }
}
