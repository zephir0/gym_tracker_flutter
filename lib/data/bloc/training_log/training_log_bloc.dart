import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_previous_training_logs_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_training_logs_use_case.dart';
import 'package:logger/logger.dart'; 

class TrainingLogBloc extends Bloc<TrainingLogEvent, TrainingLogState> {
  
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  TrainingLogBloc() : super(TrainingLogInitial()) {
    on<FetchTrainingLogs>(_onFetchTrainingLogs);
    on<FetchPreviousTrainingLogs>(_onFetchPreviousTrainingLogs);
  }

  void _onFetchTrainingLogs(
      FetchTrainingLogs event, Emitter<TrainingLogState> emit) async {
    logger.i("Fetching training logs for sessionId: ${event.sessionId}");
    final fetchTrainingLogsUseCase = getIt<FetchTrainingLogsUseCase>();
    final failureOrLogs = await fetchTrainingLogsUseCase(event.sessionId);
    failureOrLogs.fold(
      (failure) {
        logger.e("Failed to fetch training logs: $failure");
        emit(TrainingLogError());
      },
      (logs) {
        logger.i("Training logs fetched successfully");
        emit(TrainingLogsLoaded(logs));
      },
    );
  }

  void _onFetchPreviousTrainingLogs(
      FetchPreviousTrainingLogs event, Emitter<TrainingLogState> emit) async {
    logger.i("Fetching previous training logs for routineId: ${event.routineId}");
    final fetchPreviousTrainingLogsUseCase =
        getIt<FetchPreviousTrainingLogsUseCase>();
    final failureOrLogs =
        await fetchPreviousTrainingLogsUseCase(event.routineId);
    failureOrLogs.fold(
      (failure) {
        logger.e("Failed to fetch previous training logs: $failure");
        emit(TrainingLogError());
      },
      (logs) {
        logger.i("Previous training logs fetched successfully");
        emit(TrainingLogsLoaded(logs));
      },
    );
  }
}
