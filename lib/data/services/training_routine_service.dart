import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class TrainingRoutineService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  Future<List<TrainingRoutine>> getTrainingRoutines() async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.trainingRoutines}/user',
        options: Options(
          // Empty headers to avoid duplicate Authorization header
          headers: {},
        ),
      );

      // Logging
      _logger.d('Fetching training routines');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<TrainingRoutine> trainingRoutines = jsonData.map((data) => TrainingRoutine.fromJson(data)).toList();
        return trainingRoutines;
      } else {
        throw Exception('Failed to load training routines');
      }
    } catch (e) {
      _logger.e('Error loading training routines: $e');
      throw Exception('Failed to load training routines: $e');
    }
  }

  Future<bool> createTrainingRoutine(Map<String, dynamic> routineData) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.trainingRoutines}',
        data: jsonEncode(routineData),
        options: Options(
          // Empty headers to avoid duplicate Authorization header
          headers: {},
        ),
      );

      // Logging
      _logger.d('Creating training routine with data: $routineData');

      return response.statusCode == 201;
    } catch (e) {
      _logger.e('Error creating training routine: $e');
      throw Exception('Failed to create training routine: $e');
    }
  }

  Future<void> archiveTrainingRoutine(int routineId) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.trainingRoutines}/$routineId',
        options: Options(
          // Empty headers to avoid duplicate Authorization header
          headers: {},
        ),
      );

      // Logging
      _logger.d('Archiving training routine with ID: $routineId');

      if (response.statusCode != 200) {
        throw Exception('Failed to archive training routine');
      }
    } catch (e) {
      _logger.e('Error archiving training routine: $e');
      throw Exception('Failed to archive training routine: $e');
    }
  }
}
