import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/core/token/token_receiver.dart';
import 'package:injectable/injectable.dart';
@singleton
class TrainingRoutineService {
  final Dio _dio;

  TrainingRoutineService() : _dio = getIt<Dio>(); // Upewnij się, że _dio jest inicjowane poprawnie

  Future<List<TrainingRoutine>> getTrainingRoutines() async {
    try {
      String? token = await TokenReceiver().getToken();
      print('Fetching training routines with token: $token');

      Response response = await _dio.get(
        '${ApiEndpoints.trainingRoutines}/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<TrainingRoutine> trainingRoutines = jsonData.map((data) => TrainingRoutine.fromJson(data)).toList();
        return trainingRoutines;
      } else {
        throw Exception('Failed to load training routines');
      }
    } catch (e) {
      print('Error loading training routines: $e');
      throw Exception('Failed to load training routines: $e');
    }
  }

  Future<bool> createTrainingRoutine(Map<String, dynamic> routineData) async {
    try {
      String? token = await TokenReceiver().getToken();
      print('Creating training routine with token: $token');

      Response response = await _dio.post(
        '${ApiEndpoints.trainingRoutines}',
        data: jsonEncode(routineData),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error creating training routine: $e');
      throw Exception('Failed to create training routine: $e');
    }
  }

  Future<void> archiveTrainingRoutine(int routineId) async {
    try {
      String? token = await TokenReceiver().getToken();
      print('Archiving training routine with ID: $routineId and token: $token');

      Response response = await _dio.put(
        '${ApiEndpoints.trainingRoutines}/$routineId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to archive training routine');
      }
    } catch (e) {
      print('Error archiving training routine: $e');
      throw Exception('Failed to archive training routine: $e');
    }
  }
}
