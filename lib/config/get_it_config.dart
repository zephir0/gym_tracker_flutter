import 'package:get_it/get_it.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<TrainingRoutineService>(TrainingRoutineService());
  getIt.registerSingleton<TrainingSessionService>(TrainingSessionService());
  getIt.registerSingleton<TrainingLogService>(TrainingLogService());
}
