import 'package:get_it/get_it.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_previous_training_logs_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_training_logs_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/archive_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/create_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/get_training_routines_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/create_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/delete_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/fetch_recent_training_sessions_use_case.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<TrainingRoutineService>(TrainingRoutineService());
  getIt.registerLazySingleton(() => CreateTrainingRoutineUseCase());
  getIt.registerLazySingleton(() => GetTrainingRoutinesUseCase());
  getIt.registerLazySingleton(() => ArchiveTrainingRoutineUseCase());

  getIt.registerSingleton<TrainingSessionService>(TrainingSessionService());
  getIt.registerLazySingleton(() => CreateTrainingSessionUseCase());
  getIt.registerLazySingleton(() => FetchRecentTrainingSessionsUseCase());
  getIt.registerLazySingleton(() => DeleteTrainingSessionUseCase());

  getIt.registerSingleton<TrainingLogService>(TrainingLogService());
  getIt.registerLazySingleton(() => FetchTrainingLogsUseCase());
  getIt.registerLazySingleton(() => FetchPreviousTrainingLogsUseCase());
}
