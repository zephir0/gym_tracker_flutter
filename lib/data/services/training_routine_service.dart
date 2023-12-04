import 'dart:convert';

import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/token/token_receiver.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

class TrainingRoutineService {
  Future<List<TrainingRoutine>> getTrainingRoutines() async {
    String? token = await TokenReceiver().getToken();

    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-routines/user');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (response.statusCode == 200) {
      var trainingRoutines = (json.decode(response.body) as List)
          .map((data) => TrainingRoutine.fromJson(data))
          .toList();
      return trainingRoutines;
    } else {
      throw Exception('Failed to load training routines');
    }
  }

  Future<bool> createTrainingRoutine(Map<String, dynamic> routineData) async {
    String? token = await TokenReceiver().getToken();
    var url = GlobalVariables().backendApiAddress + 'api/training-routines';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + '$token',
      },
      body: jsonEncode(routineData),
    );

    return response.statusCode == 201;
  }

  Future<void> archiveTrainingRoutine(int routineId) async {
    String? token = await TokenReceiver().getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-routines/$routineId');

    final response = await http.put(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to archive training routine');
    }
  }
}
