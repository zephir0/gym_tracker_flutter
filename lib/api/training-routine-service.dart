import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/training-routine.dart';

class TrainingRoutineService {
  Future<List<TrainingRoutine>> getTrainingRoutines() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();

    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-routines/user');

    final request = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );

    if (request.statusCode == 200) {
      var trainingRoutines = (json.decode(request.body) as List)
          .map((data) => TrainingRoutine.fromJson(data))
          .toList();
      return trainingRoutines;
    } else {
      throw Exception('Failed to load training sessions');
    }
  }

  Future<int> createTrainingRoutine(Map<String, dynamic> routine) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    final url = GlobalVariables().backendApiAddress + 'api/training-routines';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + '$token'
      },
      body: jsonEncode(routine),
    );

    return response.statusCode;
  }
}
