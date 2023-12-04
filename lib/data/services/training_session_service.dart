import 'dart:convert';

import 'package:gym_tracker_flutter/data/models/training_session.dart';
import 'package:gym_tracker_flutter/token/token_receiver.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

class TrainingSessionService {
  Future<List<TrainingSession>> fetchRecentTrainingSessions() async {
    String? token = await TokenReceiver().getToken();
    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-sessions/user');
    final request = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (request.statusCode == 200) {
      List<dynamic> responseBody = json.decode(request.body);
      return responseBody
          .map((data) => TrainingSession.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  Future<void> createTrainingSession(String jsonData) async {
    String? token = await TokenReceiver().getToken();
    final response = await http.post(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/training-sessions/'),
      body: jsonData,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create training session');
    }
  }

  Future<void> deleteTrainingSession(int sessionId) async {
    String? token = await TokenReceiver().getToken();
    final response = await http.delete(
      Uri.parse(GlobalVariables().backendApiAddress +
          'api/training-sessions/$sessionId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete training session');
    }
  }

  Future<int> getWorkoutCount() async {
    String? token = await TokenReceiver().getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/progress-tracker/training-sessions/workouts-count');
    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (request.statusCode == 200) {
      return int.parse(request.body);
    } else {
      throw Exception('Failed to load workouts count');
    }
  }
}
