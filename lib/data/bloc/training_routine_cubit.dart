import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:http/http.dart' as http;

import '../models/training_routine.dart';

class TrainingRoutineCubit extends Cubit<List<TrainingRoutine>> {
  TrainingRoutineCubit() : super([]);

  Future<void> getTrainingRoutines() async {
    try {
      String? token =
          await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
      var url = Uri.parse(
          GlobalVariables().backendApiAddress + 'api/training-routines/user');
      final request =
          await http.get(url, headers: {'Authorization': 'Bearer ' + '$token'});

      if (request.statusCode == 200) {
        var trainingRoutines = (json.decode(request.body) as List)
            .map((data) => TrainingRoutine.fromJson(data))
            .toList();
        emit(trainingRoutines);
      } else {
        emit([]);
      }
    } catch (e) {
      emit([]);
    }
  }

  Future<bool> createTrainingRoutine(Map<String, dynamic> routine) async {
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
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> archiveTrainingRoutine(routineId) async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    var url = Uri.parse(GlobalVariables().backendApiAddress +
        'api/training-routines/$routineId');
    final request = await http.put(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });
    if (request.statusCode == 200) {
      final updatedList =
          state.where((routine) => routine.id != routineId).toList();
      emit(updatedList);
    }
  }
}
