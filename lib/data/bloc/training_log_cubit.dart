import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

import '../models/training_log.dart';

class TrainingLogCubit extends Cubit<List<TrainingLog>> {
  TrainingLogCubit() : super([]);

  void fetchTrainingLogs(var sessionId) async {
    try {
      var logs = await _getAllLogsForTrainingSession(sessionId);
      emit(logs);
    } catch (e) {
      emit([]);
    }
  }

  Future<List<TrainingLog>> _getAllLogsForTrainingSession(var sessionId) async {
    String? token = await TokenStorage(
      secureStorage: FlutterSecureStorage(),
    ).getToken();

    var url = Uri.parse(
      GlobalVariables().backendApiAddress +
          'api/training-logs/session/$sessionId',
    );

    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (request.statusCode == 200) {
      var trainingLogs = (json.decode(request.body) as List)
          .map((data) => TrainingLog.fromJson(data))
          .toList();
      return trainingLogs;
    } else {
      throw Exception('Failed to load training logs');
    }
  }

  void fetchPreviousTrainingLogs(var routineId) async {
    String? token = await TokenStorage(
      secureStorage: FlutterSecureStorage(),
    ).getToken();

    var url = Uri.parse(
      GlobalVariables().backendApiAddress +
          'api/training-routines/previous-logs/$routineId',
    );

    try {
      final request = await http.get(url, headers: {
        'Authorization': 'Bearer ' + '$token',
      });

      if (request.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(request.body);

        List<TrainingLog> trainingLogs = jsonData.entries.map((entry) {
          return TrainingLog.fromJson(
              {...entry.value, 'id': int.parse(entry.key)});
        }).toList();

        emit(trainingLogs);
      } else {
        emit([]);
      }
    } catch (e) {
      print(e);
      emit([]);
    }
  }
}
