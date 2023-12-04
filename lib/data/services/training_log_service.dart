import 'dart:convert';

import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/token/token_receiver.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

class TrainingLogService {
  Future<List<TrainingLog>> fetchTrainingLogs(int sessionId) async {
    String? token = await TokenReceiver().getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-logs/session/$sessionId');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var trainingLogs = (json.decode(response.body) as List)
          .map((data) => TrainingLog.fromJson(data))
          .toList();
      return trainingLogs;
    } else {
      throw Exception('Failed to load training logs');
    }
  }

  Future<List<TrainingLog>> fetchPreviousTrainingLogs(int routineId) async {
    String? token = await TokenReceiver().getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-routines/previous-logs/$routineId');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<TrainingLog> trainingLogs = jsonData.entries.map((entry) {
        return TrainingLog.fromJson(
            {...entry.value, 'id': int.parse(entry.key)});
      }).toList();
      return trainingLogs;
    } else {
      throw Exception('Failed to load previous training logs');
    }
  }
}
