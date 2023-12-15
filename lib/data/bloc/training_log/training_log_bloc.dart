import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_previous_training_logs_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_log/fetch_training_logs_use_case.dart';

class TrainingLogBloc extends Bloc<TrainingLogEvent, TrainingLogState> {
  TrainingLogBloc() : super(TrainingLogInitial()) {
    on<FetchTrainingLogs>(_onFetchTrainingLogs);
    on<FetchPreviousTrainingLogs>(_onFetchPreviousTrainingLogs);
  }

  void _onFetchTrainingLogs(
      FetchTrainingLogs event, Emitter<TrainingLogState> emit) async {
    final fetchTrainingLogsUseCase = getIt<FetchTrainingLogsUseCase>();
    final failureOrLogs = await fetchTrainingLogsUseCase(event.sessionId);
    failureOrLogs.fold(
      (failure) => emit(TrainingLogError()),
      (logs) => emit(TrainingLogsLoaded(logs)),
    );
  }

  void _onFetchPreviousTrainingLogs(
      FetchPreviousTrainingLogs event, Emitter<TrainingLogState> emit) async {
    final fetchPreviousTrainingLogsUseCase =
        getIt<FetchPreviousTrainingLogsUseCase>();
    final failureOrLogs =
        await fetchPreviousTrainingLogsUseCase(event.routineId);
    failureOrLogs.fold(
      (failure) => emit(TrainingLogError()),
      (logs) => emit(TrainingLogsLoaded(logs)),
    );
  }
}
