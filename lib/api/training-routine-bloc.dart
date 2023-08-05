import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_tracker_flutter/utills/global_variables.dart';
import 'package:gym_tracker_flutter/token/token_storage.dart';
import 'package:http/http.dart' as http;

import 'models/training-routine.dart';

class TrainingRoutineBloc {
  final _routinesController =
      StreamController<List<TrainingRoutine>>.broadcast();

  Stream<List<TrainingRoutine>> get routines => _routinesController.stream;

  final _createRoutineController = StreamController<int>.broadcast();
  Stream<int> get createRoutine => _createRoutineController.stream;

  final _archiveRoutineController = StreamController<void>.broadcast();
  Stream<void> get archiveRoutine => _archiveRoutineController.stream;

  Future<void> getTrainingRoutines() async {
    String? token =
        await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
    var url = Uri.parse(
        GlobalVariables().backendApiAddress + 'api/training-routines/user');
    final request = await http.get(url, headers: {
      'Authorization': 'Bearer ' + '$token',
    });

    if (request.statusCode == 200) {
      var trainingRoutines = (json.decode(request.body) as List)
          .map((data) => TrainingRoutine.fromJson(data))
          .toList();
      _routinesController.add(trainingRoutines);
    } else {
      _routinesController.addError('Failed to load training sessions');
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
      _routinesController.addError('Failed to create training routine');
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
    if (request.statusCode != 200) {
      _archiveRoutineController.addError('Failed to delete training routine');
    }
  }

  void dispose() {
    _routinesController.close();
    _archiveRoutineController.close();
  }
}
