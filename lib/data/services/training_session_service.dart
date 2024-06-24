import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/models/training_session.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class TrainingSessionService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  Future<List<TrainingSession>> fetchRecentTrainingSessions() async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.trainingSessions}/user',
        options: Options(
          headers: {
          },
        ),
      );

      _logger.d('Fetching recent training sessions');

      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data;
        List<TrainingSession> sessions = responseBody
            .map((data) => TrainingSession.fromJson(data))
            .toList();
        return sessions;
      } else {
        throw Exception('Failed to load training sessions');
      }
    } catch (e) {
      _logger.e('Failed to load training sessions: $e');
      throw Exception('Failed to load training sessions: $e');
    }
  }

  Future<void> createTrainingSession(String jsonData) async {
    try {
      Response response = await _dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.trainingSessions}',
        data: jsonData,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      _logger.d('Creating training session');

      if (response.statusCode != 201) {
        throw Exception('Failed to create training session');
      }
    } catch (e) {
      _logger.e('Failed to create training session: $e');
      throw Exception('Failed to create training session: $e');
    }
  }

  Future<void> deleteTrainingSession(int sessionId) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.trainingSessions}/$sessionId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      _logger.d('Deleting training session with ID: $sessionId');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete training session');
      }
    } catch (e) {
      _logger.e('Failed to delete training session: $e');
      throw Exception('Failed to delete training session: $e');
    }
  }

  Future<int> getWorkoutCount() async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.baseUrl}/progress-tracker/training-sessions/workouts-count',
        options: Options(
          headers: {
          },
        ),
      );

      _logger.d('Fetching workouts count');

      if (response.statusCode == 200) {
        return int.parse(response.data.toString());
      } else {
        throw Exception('Failed to load workouts count');
      }
    } catch (e) {
      _logger.e('Failed to load workouts count: $e');
      throw Exception('Failed to load workouts count: $e');
    }
  }
}
