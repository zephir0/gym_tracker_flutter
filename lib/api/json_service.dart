import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/training-session.dart';

class JsonService {
  Future<List<TrainingSession>> getRecentTrainingSessions() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-sessions/user');

    final request = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );

    print("Przyjety token: " + token!);

    if (request.statusCode == 200) {
      var trainingSessionList = (json.decode(request.body) as List)
          .map((data) => TrainingSession.fromJson(data))
          .toList();
      return trainingSessionList;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }
}
