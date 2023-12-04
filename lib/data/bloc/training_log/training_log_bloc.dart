import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';

class TrainingLogBloc extends Bloc<TrainingLogEvent, TrainingLogState> {
  final TrainingLogService service;

  TrainingLogBloc(this.service) : super(TrainingLogInitial()) {
    on<FetchTrainingLogs>(_onFetchTrainingLogs);
    on<FetchPreviousTrainingLogs>(_onFetchPreviousTrainingLogs);
  }

  void _onFetchTrainingLogs(
      FetchTrainingLogs event, Emitter<TrainingLogState> emit) async {
    try {
      List<TrainingLog> logs = await service.fetchTrainingLogs(event.sessionId);
      emit(TrainingLogsLoaded(logs));
    } catch (e) {
      emit(TrainingLogError());
    }
  }

  void _onFetchPreviousTrainingLogs(
      FetchPreviousTrainingLogs event, Emitter<TrainingLogState> emit) async {
    try {
      List<TrainingLog> logs =
          await service.fetchPreviousTrainingLogs(event.routineId);
      emit(TrainingLogsLoaded(logs));
    } catch (e) {
      emit(TrainingLogError());
    }
  }
}
