import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class TrainingLogService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  Future<List<TrainingLog>> fetchTrainingLogs(int sessionId) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.trainingLogs}/session/$sessionId',
        options: Options(
          headers: {
          },
        ),
      );

      _logger.d('Fetching training logs for session ID: $sessionId');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<TrainingLog> trainingLogs = jsonData.map((data) => TrainingLog.fromJson(data)).toList();
        return trainingLogs;
      } else {
        throw Exception('Failed to load training logs');
      }
    } catch (e) {
      _logger.e('Failed to load training logs: $e');
      throw Exception('Failed to load training logs: $e');
    }
  }

  Future<List<TrainingLog>> fetchPreviousTrainingLogs(int routineId) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.trainingRoutines}/previous-logs/$routineId',
        options: Options(
          headers: {
          },
        ),
      );

      _logger.d('Fetching previous training logs for routine ID: $routineId');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<TrainingLog> trainingLogs = jsonData.map((entry) {
          return TrainingLog.fromJson({...entry.value, 'id': int.parse(entry.key)});
        }).toList();
        return trainingLogs;
      } else {
        throw Exception('Failed to load previous training logs');
      }
    } catch (e) {
      _logger.e('Failed to load previous training logs: $e');
      throw Exception('Failed to load previous training logs: $e');
    }
  }
}
