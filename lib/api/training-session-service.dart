import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../auth/widgets/error_dialog.dart';
import '../model/training-session.dart';
import '../training-session/training-session-creator/training-session-creator-page.dart';

class TrainingSessionService {
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

  Future<void> startTrainingSession(jsonData, context) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    final response = await http.post(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/training-sessions/'),
      body: jsonData,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (response.statusCode == 201) {
      print("success" + response.body);
    } else {
      print(response.body);
      ErrorDialog.showErrorDialog(context, "Failed to start training session");
    }
  }
}
