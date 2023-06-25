import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/training_log.dart';

class TrainingLogService {
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
}
