import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../utills/global_variables.dart';
import 'models/training-session.dart';

class TrainingSessionState {
  final List<TrainingSession> sessions;
  final int workoutCount;

  TrainingSessionState(this.sessions, this.workoutCount);
}

class TrainingSessionCubit extends Cubit<TrainingSessionState> {
  TrainingSessionCubit() : super(TrainingSessionState([], 0));

  void fetchRecentTrainingSessions() async {
    try {
      List<TrainingSession> sessions = await _getRecentTrainingSessions();
      String count = await getWorkoutCount();
      emit(TrainingSessionState(sessions, int.parse(count)));
    } catch (e) {}
  }

  Future<List<TrainingSession>> _getRecentTrainingSessions() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
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

  void createTrainingSession(String jsonData) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    final response = await http.post(
      Uri.parse(GlobalVariables().backendApiAddress + 'api/training-sessions/'),
      body: jsonData,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201) {
      fetchRecentTrainingSessions();
    } else {}
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
      emit(TrainingSessionState(state.sessions, int.parse(request.body)));
      return request.body;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  void deleteTrainingSession(int sessionId) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    final response = await http.delete(
      Uri.parse(GlobalVariables().backendApiAddress +
          'api/training-sessions/$sessionId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      emit(TrainingSessionState(state.sessions, state.workoutCount - 1));
    } else {}
  }
}
