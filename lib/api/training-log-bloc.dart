import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import 'models/training_log.dart';

class TrainingLogBloc {
  final _trainingLogStateController = StreamController<List<TrainingLog>>();

  Stream<List<TrainingLog>> get trainingLogs =>
      _trainingLogStateController.stream;

  final _trainingPreviousLogStateController =
      StreamController<Map<int, TrainingLog>>.broadcast();

  Stream<Map<int, TrainingLog>> get previousTrainingLogs =>
      _trainingPreviousLogStateController.stream;

  TrainingLogBloc();

  fetchTrainingLogs(sessionId) async {
    var logs = await _getAllLogsForTrainingSession(sessionId);
    _trainingLogStateController.sink.add(logs);
  }

  fetchPreviousEntries() async {
    try {
      var logs = await fetchPreviousTrainingLogs();
      _trainingPreviousLogStateController.sink.add(logs);
    } catch (e) {
      _trainingPreviousLogStateController.sink
          .addError('Failed to load training sessions');
    }
  }

  Future<List<TrainingLog>> _getAllLogsForTrainingSession(var sessionId) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-logs/gym-diary/$sessionId');

    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (request.statusCode == 200) {
      var trainingLogs = (json.decode(request.body) as List)
          .map((data) => TrainingLog.fromJson(data))
          .toList();
      return trainingLogs;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  Future<Map<int, TrainingLog>> fetchPreviousTrainingLogs() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-routines/previous-logs/214');

    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (request.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(request.body);

      Map<int, TrainingLog> trainingLogs = {};

      jsonData.entries.forEach((entry) {
        int exerciseId = int.parse(entry.key);
        TrainingLog log = TrainingLog.fromJson(entry.value);
        trainingLogs[exerciseId] = log;
      });

      return trainingLogs;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  void dispose() {
    _trainingLogStateController.close();
    _trainingPreviousLogStateController.close();
  }
}
