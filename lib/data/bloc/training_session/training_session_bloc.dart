import 'package:bloc/bloc.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/create_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/delete_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/fetch_recent_training_sessions_use_case.dart';
import 'package:gym_tracker_flutter/utills/no_parameters.dart';

class TrainingSessionBloc
    extends Bloc<TrainingSessionEvent, TrainingSessionState> {
  TrainingSessionBloc() : super(TrainingSessionInitial()) {
    on<FetchTrainingSessions>(_onFetchTrainingSessions);
    on<CreateTrainingSession>(_onCreateTrainingSession);
    on<DeleteTrainingSession>(_onDeleteTrainingSession);
  }

  Future<void> _onFetchTrainingSessions(
    FetchTrainingSessions event,
    Emitter<TrainingSessionState> emit,
  ) async {
    final fetchRecentTrainingSessionsUseCase =
        getIt<FetchRecentTrainingSessionsUseCase>();
    final sessionsOrFailure =
        await fetchRecentTrainingSessionsUseCase(NoParameters());

    sessionsOrFailure.fold(
      (failure) => emit(TrainingSessionError()),
      (sessions) => emit(TrainingSessionLoaded(sessions)),
    );
  }

  Future<void> _onCreateTrainingSession(
    CreateTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    final createTrainingSessionUseCase = getIt<CreateTrainingSessionUseCase>();
    await createTrainingSessionUseCase(event.jsonData);
    add(FetchTrainingSessions());
  }

  Future<void> _onDeleteTrainingSession(
    DeleteTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    final deleteTrainingSessionUseCase = getIt<DeleteTrainingSessionUseCase>();
    await deleteTrainingSessionUseCase(event.sessionId);
    add(FetchTrainingSessions());
  }
}
