import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/global_variables.dart';
import 'package:gym_tracker_flutter/model/training-routine.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/training-session.dart';
import '../model/training_log.dart';

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

  Future<List<TrainingLog>> getAllLogsForTrainingSession(var sessionId) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-logs/gym-diary/$sessionId');

    final request = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (request.statusCode == 200) {
      var trainingLogs = (json.decode(request.body) as List)
          .map((data) => TrainingLog.fromJson(data))
          .toList();
      return trainingLogs;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  Future<List<TrainingRoutine>> getTrainingRoutines() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-routines/user');

    final request = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (request.statusCode == 200) {
      var trainingRoutines = (json.decode(request.body) as List)
          .map((data) => TrainingRoutine.fromJson(data))
          .toList();
      return trainingRoutines;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

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
