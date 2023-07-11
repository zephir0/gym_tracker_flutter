import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;
import '../utills/global_variables.dart';
import 'models/training-session.dart';

class TrainingSessionBloc {
  final _trainingSessionStateController =
      StreamController<List<TrainingSession>>.broadcast();

  final _workoutCounter = StreamController<String>.broadcast();
  Stream<String> get workoutCounter => _workoutCounter.stream;

  Stream<List<TrainingSession>> get recentTrainingSessions =>
      _trainingSessionStateController.stream;

  TrainingSessionBloc() {
    getWorkoutCount().then((value) => _workoutCounter.sink.add(value));
    fetchRecentTrainingSessions();
  }

  fetchRecentTrainingSessions() async {
    var sessions = await _getRecentTrainingSessions();
    _trainingSessionStateController.sink.add(sessions);
  }

  Future<List<TrainingSession>> _getRecentTrainingSessions() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-sessions/user');
    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });
    if (request.statusCode == 200) {
      var trainingSessionList = (json.decode(request.body) as List)
          .map((data) => TrainingSession.fromJson(data))
          .toList();
      getWorkoutCount().then((value) => _workoutCounter.sink.add(value));

      return trainingSessionList;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  Future<String> getWorkoutCount() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/progress-tracker/training-sessions/workouts-count');
    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });
    if (request.statusCode == 200) {
      return request.body;
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
    if (response.statusCode != 201) {
      throw Exception('Failed to start training session');
    }
    getWorkoutCount().then((value) => _workoutCounter.sink.add(value));
  }

  Future<void> deleteTrainingSession(sessionId) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    final response = await http.delete(
      Uri.parse(GlobalVariables().backendApiAddress +
          'api/training-sessions/$sessionId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + '$token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete training session');
    }

    fetchRecentTrainingSessions();
    getWorkoutCount().then((value) => _workoutCounter.sink.add(value));
  }

  void dispose() {
    _trainingSessionStateController.close();
    _workoutCounter.close();
  }
}
