import 'package:bloc/bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';

import '../../models/training_session.dart';

class TrainingSessionBloc
    extends Bloc<TrainingSessionEvent, TrainingSessionState> {
  final TrainingSessionService service;

  TrainingSessionBloc(this.service) : super(TrainingSessionInitial()) {
    on<FetchTrainingSessions>(_onFetchTrainingSessions);
    on<CreateTrainingSession>(_onCreateTrainingSession);
    on<DeleteTrainingSession>(_onDeleteTrainingSession);
  }

  void _onFetchTrainingSessions(
    FetchTrainingSessions event,
    Emitter<TrainingSessionState> emit,
  ) async {
    try {
      List<TrainingSession> sessions =
          await service.fetchRecentTrainingSessions();
      int count = await service.getWorkoutCount();
      emit(TrainingSessionLoaded(sessions, count));
    } catch (e) {
      emit(TrainingSessionError());
    }
  }

  void _onCreateTrainingSession(
    CreateTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    try {
      await service.createTrainingSession(event.jsonData);
      add(FetchTrainingSessions());
    } catch (e) {
      emit(TrainingSessionError());
    }
  }

  void _onDeleteTrainingSession(
    DeleteTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    try {
      await service.deleteTrainingSession(event.sessionId);
      add(FetchTrainingSessions());
    } catch (e) {
      emit(TrainingSessionError());
    }
  }
}
