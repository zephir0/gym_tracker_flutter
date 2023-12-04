import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';

class TokenReceiver {
  Future<String> getToken() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    return token;
  }
}
